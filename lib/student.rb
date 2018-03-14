#####new                                                                                                                                                                
#takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash.
#adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable.
#####.create_from_collection
#uses the Scraper class to create new students with the correct name and location.
#####add_student_attributes
#uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student.
#####.all
#returns the class variable @@all

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |i, j|
      self.send("#{i}=", j)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash|
      Student.new(hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |i, j|
      self.send("#{i}=", j)
    end
    self
  end

  def self.all
    @@all
  end
end
