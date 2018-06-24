class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
   student_hash.each do |spec, value| 
   	self.send("#{spec}=", value)
   end #end the each-do
   	@@all << self
  end #end the initialize method

  def self.create_from_collection(students_array)
    students_array.each do |student_hash| # for each object in the array
    	Student.new(student_hash) #creates a new student with the object
    end #end the each do
  end#end the create method

  def add_student_attributes(attributes_hash)
     attributes_hash.each do |attr, value| #from the hash get each attribute and value
      self.send("#{attr}=", value) #send the studen tthe new attribute/value key pair
    end #end the each-do
    self #call self
  end #end the add attributes method

  def self.all
    @@all
  end#end the self all
end #end the student class
