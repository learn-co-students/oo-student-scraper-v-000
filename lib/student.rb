
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  # Array to contain all the students and their attributes hashes
  @@all = []

  # Initialize a new student by being able to mass assign their
  # attributes a key and value according to what the hash argument contains
  def initialize(student_hash)
    student_hash.each {|key,value| self.send(("#{key}="), value)}
    @@all << self  # Adds each new student hash to the @@all array
  end

  # Creates new student hashes from an array of students
  # Calls on initialize to create the hashes
  def self.create_from_collection(students_array)
    students_array.each {|student| self.new(student)}
  end

  # Adds a students attributes to their hash
  # Uses mass assignment to only add the attributes a student has
  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  # Allows the student array to be called
  def self.all
    @@all
  end
end
