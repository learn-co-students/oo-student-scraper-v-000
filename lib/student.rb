class Student
require 'pry'
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    self.send("name=", student_hash[:name])
    self.send("location=", student_hash[:location])
    # self.send("profile_url=", student_hash[:profile_url])
    @@all << self
  end

  def self.create_from_collection(students_array)
    #students_array is an array of hashes with name, location of each student 
    #look at students_array and pic each student hash and create a new student from that student_hash
    #how does the scraper class ineract???
    students_array.each do |student_hash|
     Student.new(student_hash) 
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v| 
      self.send("#{k}=", v)
    end
      @@all << self
    
  end

  def self.all
    @@all
  end
end


