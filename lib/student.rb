class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self

  end

  def self.create_from_collection(students_array)
    students_array.each{|student_hash| self.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @bio = attributes_hash[:bio]
    @profile_quote = attributes_hash[:profile_quote]
    @linkedin = attributes_hash[:linkedin]
  end

  def self.all
    @@all
  end
end
