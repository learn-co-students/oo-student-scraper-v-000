class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    # Use send method to assign the newly created student #attributes and values in accordance with the key#/value pairs of the hash.
    
    #Send method also adds newly created student to the Student class' @@all array of all students. You'll need to create a class variable and set equal to an empty array at top of your class.  Push self into the array at the end of the #initialize method.  
    
    
  end


  def self.create_from_collection(students_array)
    # This method should iterate over the array of hashes #and create a new individual student using each hash. 
  end


  def add_student_attributes(attributes_hash)
    # This instance methods takes in a hash whose k/v pairs describe add'l attirubtes of an individual student.   
    
    #Call student.add_student_attributes with the return value of the Scraper.scrape_profile_page metho as the argument. 
    
    # This method should iterate over the given hash and use metaprogramming to dynamically assign the student attributes and values in accordance with the key/value pairs of the hash. Use the #send method to achieve this.
    
    #Important: The return value of this method should be the student itself. Use the self keyword.
    
    
  end

  
  
  def self.all
    # This class method should return the contents of the @@all array.
    
    
  end



end

