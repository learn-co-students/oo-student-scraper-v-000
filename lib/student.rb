class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash) 
    student_hash.each do |key, value|
      self.send(("#{key}="), value) 
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
  end

#This instance method should take in a hash whose key/value pairs describe additional attributes of an individual student. In fact, we will be calling student.add_student_attributes with the return value of the Scraper.scrape_profile_page method as the argument.

#The #add_student_attributes method should iterate over the given hash and use metaprogramming to dynamically assign the student attributes and values in accordance with the key/value pairs of the hash. Use the #send method to achieve this.


  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value) 
    end
    self
  end

  def self.all
    @@all
  end
end

