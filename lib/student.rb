class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  #The #initialize method should take in an argument of a hash and use metaprogramming to assign the newly created student attributes and values in accordance with the key/value pairs of the hash. Use the #send method to achieve this.
  def initialize(student_hash) 
    student_hash.each do |key, value|
      self.send(("#{key}="), value) 
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    #binding.pry
    # iterate over students_array
    # instantiate new student and assign attributes using "student_array"
    # thassit
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end
end

