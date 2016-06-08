class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
#-------------    
    # The `#initialize` method should take in an argument of a hash and 
    # use metaprogramming to assign the newly created student attributes and 
    # values in accordance with the key/value pairs of the hash. 
    # Use the `#send` method to acheive this. 
    # This method should also add the newly created student to the 
    # `Student` class' `@@all` array of all students. You'll need to create 
    # this class variable and set it equal to an empty array at the top of 
    # your class. Push `self` into the array at the end of 
    # the `#initialize` method.
#-------------
    student_hash.each {|key, value| self.send(("#{key}="), value)}

    @@all << self
  end

  def self.create_from_collection(students_array)
#-------------
    # This class method should take in an array of hashes. In fact, we will
    # call `Student.create_from_collection` with the return value of the
    # `Scraper.scrape_index_page` method as the argument. The
    # `#create_from_collection` method should iterate over the array of hashes
    # and create a new individual student using each hash. This brings us to 
    # the `#initialize` method on our `Student` class.
#-------------
     students_array.each {|student| Student.new(student)}
  end

  def add_student_attributes(attributes_hash)
    # This instance method should take in a hash whose key/value pairs describe
    # additional attributes of an individual student. In fact, we will be calling
    # `student.add_student_attributes` with the return value of the `Scraper.scrape_profile_page` 
    # method as the argument.

    # The `#add_student_attributes` method should iterate over the given hash and use metaprogramming
    # to dynamically assign the student attributes and values in accordance with the key/value pairs
    # of the hash. Use the `#send` method to achieve this.

    # **Important:** The return value of this method should be the student itself. Use the `self` keyword.

    attributes_hash.each {|key, value| self.send(("#{key}="), value)}


  end

  def self.all
    @@all
  end
end


