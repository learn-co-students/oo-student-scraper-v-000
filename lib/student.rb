require 'pry'

class Student

  attr_accessor :name, :location, :twitter, 
                :linkedin, :github, :blog, 
                :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |new_student| 
      if !self.find_student(new_student[:name]) 
        student = Student.new(new_student)
        student.profile_url = new_student[:profile_url]
      end
    end
  end

  def self.clear!
    @@all.clear
  end

  def self.find_student(name)
    self.all.any? do |student|
      student.name == name
    end
  end

  def add_student_attributes(attributes_hash)
    @twitter = attributes_hash[:twitter]
    @linkedin = attributes_hash[:linkedin]
    @github = attributes_hash[:github]
    @blog = attributes_hash[:blog]
    @profile_quote = attributes_hash[:profile_quote]
    @bio = attributes_hash[:bio]
    @profile_url = attributes_hash[:profile_url]
  end

  def self.all
    @@all
  end
end

