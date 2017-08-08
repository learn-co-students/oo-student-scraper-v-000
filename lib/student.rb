require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |k,v|
      self.send("#{k}=", student_hash[:"#{k}"])
    end
    @@all << self
  end

  def self.create_from_collection(students_array) #array of student hashes, creates new individual student from each hash
    students_array.each do |student|
      new_student = Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      self.send("#{k}=", attributes_hash[:"#{k}"])
    end
  end

  def self.all
    @@all
  end
end
