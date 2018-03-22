require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  #takes in an array with students' name, location, and profile URL
  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    #binding.pry
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |student_attribute|
      student_attribute.each do |key, value|
      self.send("#{student_attribute[0]}=", student_attribute[1])
      end
    end
    self
    #binding.pry
  end

  def self.all
    @@all
  end
end
