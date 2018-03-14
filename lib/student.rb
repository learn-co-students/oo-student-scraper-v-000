class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value| #takes in hash argument and sents new students attributes using key/value pairs
      self.send("#{key}=", value)
    end
    @@all << self #adds the new student to the student class' collection of @@all students
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  #adds additional attributes to the hash dynamically using #send method
  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    self
  end

  #returns all values in the @@all class variable
  def self.all
    @@all
  end
end
