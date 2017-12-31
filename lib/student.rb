class Student

  attr_accessor :name, :location, :twitter, :linkedin,
  :github, :blog, :profile_quote, :bio, :profile_url
#collection of all existing students
  @@all = []

  def initialize(student_hash)
#takes in an argument of a hash and sets that new student's
#attributes using the key/value pairs of that hash.
    student_hash.each do |key, value|
#takes in an argument of a hash and uses metaprogramming to assign the
#newly created student attributes and values in accordance with the
#key/value pairs of the hash. Uses the #send method to acheive this.
      self.send("#{key}=", value)
    end
#adds that new student to the Student class' collection of
#all existing students, stored in the `@@all` class variable.
    @@all << self
  end

#uses the Scraper class to create new students with the
#correct name and location.
  def self.create_from_collection(students_array)
#iterates over the array of hashes and creates a new
#individual student using each hash
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

#uses the Scraper class to get a hash of a given students
#attributes and uses that hash to set additional attributes for that student.
  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
      end
    self
  end

#returns the class variable @@all  end

  def self.all
    @@all
  end

end
