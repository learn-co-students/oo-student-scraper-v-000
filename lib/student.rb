require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student = student_hash.each {|key, value| self.send(("#{key}="), value)}
    self.class.all << self
  end # initialize

  def self.create_from_collection(students_array)
    students_array.each {|student_hash| Student.new(student_hash)}
  end # self.create_from_collection

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end # add_student_attributes

  def self.all
    @@all
  end # all

end # class Student
