class Student
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

# Student #new takes in an argument of a hash and sets that new student's attributes using the key/value pairs of
# that hash.
# Student #new adds that new student to the Student class' collection of all existing students, stored in the
# `@@all` class variable.
  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

# Student .create_from_collection uses the Scraper class to create new students with the correct name and location.
  def self.create_from_collection(students_array)
    students_array.each do |stud|
      self.new(stud)
    end
  end

# Student #add_student_attributes uses the Scraper class to get a hash of a given students attributes and uses
# that hash to set additional attributes for that student.
  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

# Student .all returns the class variable @@all
  def self.all
    @@all
  end
end
