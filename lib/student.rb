class Student

  #In this lab, you'll be scraping your Learn.co student website. You'll use the index page to grab a list of current students and instantiate a series of `Student` objects. You'll scrape the individual profile pages of each student to add attributes to each individual student.

  #The student class will use the information returned by the above methods from our `Scraper` class in order to create students and add attributes to individual students. However, the `Student` class shouldn't know about the `Scraper` class. This means that the `Student` class shouldn't directly interact with the `Scraper` class––it shouldn't call on the `Scraper` class in any of its methods or take in the `Scraper` class itself as an argument.

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    self << @@all
  end

  def self.create_from_collection(students_array)
    #This class method should take in an array of hashes. In fact, we will call `Student.create_from_collection` with the return value of the `Scraper.scrape_index_page` method as the argument. The `#create_from_collection` method should iterate over the array of hashes and create a new individual student using each hash. This brings us to the `#initialize` method on our `Student` class.

  end

  def add_student_attributes(attributes_hash)
    #This instance method should take in a hash whose key/value pairs describe additional attributes of an individual student. In fact, we will be calling `student.add_student_attributes` with the return value of the `Scraper.scrape_profile_page` method as the argument.

    #The `#add_student_attributes` method should iterate over the given hash and use metaprogramming to dynamically assign the student attributes and values in accordance with the key/value pairs of the hash. Use the `#send` method to achieve this.

    #**Important:** The return value of this method should be the student itself. Use the `self` keyword.
  end

  def self.all
    #This class method should return the contents of the `@@all` array.
  end
end
