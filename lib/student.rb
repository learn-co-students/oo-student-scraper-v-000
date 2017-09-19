class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash. (FAILED - 4)
    # adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable. (FAILED - 5)
  end

  def self.create_from_collection(students_array)
        # uses the Scraper class to create new students with the correct name and location. (FAILED - 6)
  end

  def add_student_attributes(attributes_hash)
        # uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student. (FAILED - 7)
  end

  def self.all
        # returns the class variable @@all (FAILED - 8)
  end
end
