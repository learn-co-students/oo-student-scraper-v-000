class Student
# gets info from the Scraper class in order to create students and add attributes
# should not call the Scraper class in any of it's methods or take it as an argument
# flexibility!
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    # use metaprogramming to assign the student attributes and values
    # add student to @@all
  end

  def self.create_from_collection(students_array)
    # take in array of hashes
    # iterate over array of hashes and create new students from each hash
  end

  def add_student_attributes(attributes_hash)
    # iterate over hash and use metaprogramming to assign the student attributes
    # use #send !
    # use self to return the student at the ened

  end

  def self.all
    @@all
  end

end
