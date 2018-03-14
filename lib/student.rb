class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = [] #Stores all the students created in class variable

  def initialize(student_hash) #when .new is called from inside create_from_collection it will get passed a hash to set params off of 
    student_hash.each do |attribute, value| #takes passed hash and iterates over each key value
      self.send("#{attribute}=", value) # sets a param named after the key and equal to the value.
    end
    @@all << self #sends newly created student to class variable for storage
  end

  def self.create_from_collection(students_array) #creates a student instance from a passed array
    students_array.each do |student_hash| # takes passed array and iterates over each object with .each
      Student.new(student_hash) #each iteration calls .new and passeds the hash object it was iterated 
    end
  end

  def add_student_attributes(attributes_hash) #adds an attribute to an extant student instance by taking in an attr hash
    attributes_hash.each do |attr, value| #interates over passed hash with .each 
      self.send("#{attr}=", value) #sets a new param based off the key value of the given hash.
    end
    self #returns a copy of the updated student instance.
  end

  def self.all #method to expose class variable so we can see all the students created
    @@all
  end
end

