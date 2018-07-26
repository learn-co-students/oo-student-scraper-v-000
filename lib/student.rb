class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url, :scraper

  @@all = []

  def initialize(student_hash)
    @@all << self

  end

  def self.create_from_collection(students_array)
    student = Student.new(name)
    @@all << student
  end

  def add_student_attributes(attributes_hash)
    Scraper.scraped_student

  end

  def self.all
    @@all

  end

  def new(student_hash)
    new_student = Student.new
    student_hash[:name] = "new_student.name"
    @@all << new_student
end
end
