require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url, :Scraper

  @@all = []

  def initialize(student_hash)

    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    # binding.pry
    students_array.each do |new_student|
      new_student = self.new(new_student)
    end
  end

  def add_student_attributes(attributes_hash)
    # binding.pry
    @twitter  = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio]
  end
binding.pry
  end

  def self.all
    # binding.pry
    @@all
  end
