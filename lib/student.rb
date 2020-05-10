class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send("#{key}=", value)}
     @@all << self
  end

# !will call Student.create_from_collection with return value of Scraper.scrape_index_page
  def self.create_from_collection(students_array) # take in array of hashes
    students_array.each do |s|  # iterate over given hash and create a new individual student using each hash
      Student.new(s)  # this will bring me to Student.initialize method
    end
  end

  def add_student_attributes(attributes_hash)
  # iterate over the given hash
  # and use meta-programming to dynamically assign student attributes and values per the k/v pairs of the hash
  # use #send method to achieve
  # !Return value of this method should be the student itself. Use the `self` keyword
  end

  def self.all
    @@all
  end
end
