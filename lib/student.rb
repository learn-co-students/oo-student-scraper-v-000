require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end 

    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each { |student_data| Student.new(student_data)}
  end

  def add_student_attributes(attributes_hash)
    # uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student.
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.all
    @@all
  end
end
