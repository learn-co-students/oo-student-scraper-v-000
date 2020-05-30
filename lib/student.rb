class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|k, v| self.send(("#{k}="), v)}
    @@all << self
  end 

  def self.create_from_collection(students_array)
    #the argument here is the students array from the Scraper class
    #this method should iterate over the array of hashes and create a new individual student using each hash using initialize 
    
    students_array.each {|student| student = self.new(student)}
  end

  def add_student_attributes(attributes_hash)
    #attributes hash from scape_profile_page method

    attributes_hash.each {|k, v| self.send(("#{k}="), v)}
  end

  def self.all
    @@all
  end
end
