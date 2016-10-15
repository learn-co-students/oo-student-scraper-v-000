require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |k, v|
      self.send("#{k}=", v)
    @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      student = Student.new(student_hash)
      student_hash.inject do |c, v|
        student.name = c[1]
        student.location = v[1]
      end
      student
    end
  end


  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      attrs = self.send("#{k}=", v)
    end
  end

  def self.all
    @@all
  end
end

