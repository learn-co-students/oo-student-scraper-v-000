class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key,value|
      @name = value if key.to_s == "name"
      @location = value if key.to_s == "location"
      @profile_url = value if key.to_s == "profile_url"
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      Student.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key,value|
      @twitter = value if key.to_s == "twitter"
      @github = value if key.to_s == "github"
      @bio = value if key.to_s == "bio"
      @blog = value if key.to_s == "blog"
      @profile_quote = value if key.to_s == "profile_quote"
      @linkedin = value if key.to_s == "linkedin"
    end
  end

  def self.all
    @@all
  end
end
#
# class Course
#   attr_accessor :title, :schedule, :description
#
#   @@all = []
#
#   def initialize
#     @@all << self
#   end
#
#   def self.all
#     @@all
#   end
#
#   def self.reset_all
#     @@all.clear
#   end
#
# end
