require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send("#{key}=", value)
      @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      self.new(hash)
    end
  end

  def add_student_attributes(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end
