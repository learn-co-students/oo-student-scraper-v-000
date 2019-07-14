class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []
  
  
# The #initialize method should take in an argument of a hash and use metaprogramming to assign the newly created student attributes and values in accordance with the key/value pairs of the hash. Use the #send method to achieve this. 
# This method should also add the newly created student to the Student class' @@all array of all students. You'll need to create this class variable and set it equal to an empty array at the top of your class. Push self into the array at the end of the #initialize method.

  def initialize(student_hash)
    student_hash.each do |attribute, value|
    self.send("#{attribute}=", value)
end
    @@all << self  
  end

 def self.create_from_collection(students_array)
    students_array.each { |student_hash| self.new(student_hash) }
  end	  
  

def add_student_attributes(attributes_hash)
    attributes_hash.each_pair { |key, value| self.send(("#{key}="), value) 
    }
end

  def self.all
    @@all  
  end
end


