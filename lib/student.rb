class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  #use metaprogramming to assign the newly created student attributes
  #and values in accordance with the key/value pairs of the hash
  #Use the #send method to acheive this.
  #This method should also add the newly created student to the Student class' @@all array of all students.
  def initialize(student_hash)
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  ##create_from_collection method should iterate over the array
  #of hashes and create a new individual student using each hash.
  def self.create_from_collection(students_array)
    students_array.each {|student_hash| Student.new(student_hash)}
  end

  #This instance method should take in a hash whose key/value pairs describe
  #additional attributes of an individual student.
  #In fact, we will be calling student.add_student_attributes with the return value
  #of the Scraper.scrape_profile_page method as the argument.
  #The #add_student_attributes method should iterate over the given hash and
  #use metaprogramming to dynamically assign the student attributes and values
  #in accordance with the key/value pairs of the hash. Use the #send method to achieve this.
  #The return value of this method should be the student itself. Use the self keyword.

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end
