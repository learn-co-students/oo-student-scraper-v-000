class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
 #use metaprogramming to assign the newly created student attributes and values by the key/values pairs of the hash
 #this will use #send. also, add the newly created student to the @@all array.
    attributes.each {|key, value| self.send(('#{key}=')), value)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    #iterates over the array of hashes and crates a new individaul student using each hash.
    #argument is: the return value of the scraper.scrape_index_page

  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end

# Scraper.new.print_students
