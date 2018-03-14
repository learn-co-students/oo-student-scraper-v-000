require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    if student_hash
        student_hash.each do |key, value|
            self.send("#{key}=", value)
        end
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student_hash| Student.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
    if attributes_hash
        attributes_hash.each do |key, value|
            self.send("#{key}=", value)
        end
    end
    self
  end

  def self.all
    @@all
  end
end

