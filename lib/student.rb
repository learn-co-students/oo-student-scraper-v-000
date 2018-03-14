class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      #ssign the newly created student attributes and values in accordance with the key/value pairs of the hash.
      self.send("#{key}=", value)
      #add the newly created student to the @@all array
      @@all << self
    end
  end

  def self.create_from_collection(students_array)
    #iterates through the students_array and creates a new student from each hash
    students_array.each do |hash|
      self.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attributes, value|
      #ssign the newly created student attributes and values in accordance with the key/value pairs of the hash.
      self.send("#{attributes}=", value)
    end
    #The return value of this method should be the student itself.
    self
  end

  def self.all
    @@all
  end

end
