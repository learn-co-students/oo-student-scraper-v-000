require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|k, v| self.send(("#{k}="), v)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    #binding.pry
    students_array.collect {|student| Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    #binding.pry
    attributes_hash.each {|k, v| self.send(("#{k}="), v)}
  end

  def self.all
    @@all
  end
end
