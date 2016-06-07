class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # The `#initialize` method should take in an argument of a hash and 
    # use metaprogramming to assign the newly created student attributes and 
    # values in accordance with the key/value pairs of the hash. 
    # Use the `#send` method to acheive this. 
    # This method should also add the newly created student to the 
    # `Student` class' `@@all` array of all students. You'll need to create 
    # this class variable and set it equal to an empty array at the top of 
    # your class. Push `self` into the array at the end of 
    # the `#initialize` method.

    student_hash.each {|key, value| self.send(("#{key}="), value)}

    @@all << self
  end

  def self.create_from_collection(students_array)
    # This class method should take in an array of hashes. In fact, we will
    # call `Student.create_from_collection` with the return value of the
    # `Scraper.scrape_index_page` method as the argument. The
    # `#create_from_collection` method should iterate over the array of hashes
    # and create a new individual student using each hash. This brings us to 
    # the `#initialize` method on our `Student` class.

    # students_array.each do |student|
      
    
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end
end


