class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
# takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash.
# adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable.
    student_hash.each_pair do |k, v|
      self.send(("#{k}="), v)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
# uses the Scraper class to create new students with the correct name and location.
  students_array.each do |array|
    self.new(array)
  end
  end

  def add_student_attributes(attributes_hash)
# uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student.
    attributes_hash.each_pair { |k, v| self.send(("#{k}="), v) }
  end

  def self.all
# returns the class variable @@all
    @@all
  end
end
