class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    #takes in an argument of a hash and sets that new student's attributes using th
    #key/value pairs of that hash.
    @@all << self
    #adds that new student to the Student class' collection of all existing students,
    #stored in the '@@all' class variable.
  end

  def self.create_from_collection(students_array)
    students_array.each { |student| self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each { |key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
