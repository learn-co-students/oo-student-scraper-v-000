class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #take in an argument of a hash and use metaprogramming to assign
    #the newly created student attributes and values
    student_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    #iterate over the array of hashes and create a new individual student using each hash Scraper.scrape_index_page
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    #iterate over Scraper.scrape_profile_page hash and use metaprogramming to dynamically assign
    attributes_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
    self
  end

  def self.all
    @@all
  end
end
