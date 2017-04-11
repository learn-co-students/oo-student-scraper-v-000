require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #mass assignment via metaprogramming
    student_hash.each_pair { |key, value| self.send("#{key}=", value) }

    #keep track of newly created student
    Student.all << self
  end

  #send hash to initialize
  def self.create_from_collection(students_array)
    students_array.each { |student| self.new(student) }
  end

  def add_student_attributes(attributes_hash)
    #iterates through each attribute and sets it
    attributes_hash.each_pair { |key, value| self.send("#{key}=", value) }
    self
  end

  def self.all
    @@all
  end
end
