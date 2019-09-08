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
    students_array.each do |one_student|
      Student.new(one_student)
    end
    self.all
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute, value|
      if attribute == :twitter
        @twitter = value
      elsif attribute == :linkedin
        @linkedin = value
      elsif attribute == :github
        @github = value
      elsif attribute == :blog
        puts(blog)
        @blog = value
      elsif attribute == :profile_quote
        @profile_quote = value
      elsif attribute == :bio
        @bio = value
      end
    end
  end

  def self.all
    return @@all
  end
end
