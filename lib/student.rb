class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
  #take in an argument of a hash and use metaprogramming to assign the newly created student attributes and values
  #in accordance with the key/value pairs of the hash.
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self

  end

  def self.create_from_collection(students_array)
    #should iterate over the array of hashes and create a new individual student using each hash.
    students_array.each {|student_hash| Student.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
