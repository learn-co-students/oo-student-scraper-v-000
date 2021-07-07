class Student
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # it should take in an argument of a hash and use metaprogramming to assign the newly created student attributes
    # and values in accordance with the key/value pairs of the hash. Use the #send method to acheive this
    # the method should also add the newly created student to the Student class' @@all array of all students
    # You'll need to create this class variable and set it equal to an empty array at the top of your class
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    # push self into the array at the end of the #initialize method
    @@all << self
  end

  def self.create_from_collection(students_array)
    # it will call with the return value of the Scraper.scrape_index_page method as the argument
    # it should iterate over the array of hashes and create a new individual student using each hash
    students_array.each do |collect|
      student = self.new(collect)
    end
  end

  def add_student_attributes(attributes_hash)
    # should take in a hash whose key/value pairs describe additional attributes of an individual student
    # we will be calling student.add_student_attributes with the return value of
    # the Scraper.scrape_profile_page method as the argument
    # should iterate over the given hash and use metaprogramming to
    # dynamically assign the student attributes and values in accordance with the key/value pairs of the hash
    # use the #send method to achieve this
    attributes_hash.each do |key, value|
      updated_student = self.send("#{key}=", value)
    end
    # Important: The return value of this method should be the student itself. Use the self keyword
    @@all << self
  end

  def self.all
    # should return the contents of the @@all array
    @@all
  end
end
