class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) #takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash
    student_hash.each do |key, value|
      self.send("#{key}=", value) #"#{key}=" is the method name reflecting the attr_accessor methods
    end
    @@all << self #adds that new student to the Student class' collection of all existing students, stored in the @@all class variable
  end

  def self.create_from_collection(students_array) #take in an array of hashes from Scraper.scrape_index_page, iterate over the array of hashes and create a new individual student using each hash. Bringing us to Initialize method
    students_array.each do |student_info|
      Student.new(student_info)
    end
  end

  def add_student_attributes(attributes_hash) #take in a hash whose key/value pairs from Scraper.scrape_profiel_page, iterate over the given hash and use metaprogramming to assign student attributes and values in key/value pairs of the hash. Use #send to do this.
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    #return value should be student itself. use self
  end

  def self.all
    @@all
  end
end
