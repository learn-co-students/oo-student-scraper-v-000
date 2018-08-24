class Student #uses information returned by Scraper class to create students and add attributes to individual students

  @@all = []

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  def initialize(student_hash) #takes argument of a hash and uses metaprogramming to assign the newly created student attributes and values
  
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  @@all << self #adds new student to array of all students
  end

  def self.create_from_collection(students_array) #iterate over the array of hashes (students_array) and create a new individual student using each hash
  
  students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  self
  end

  def self.all
    @@all
  end
end

