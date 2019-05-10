class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|info, link|self.send "#{info}=", "#{link}"}
    self.class.all << self 
    
  end

  def self.create_from_collection(students_array)
    students_array.each {|hash| Student.new(hash)}
    
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|info, link|self.send "#{info}=", "#{link}"}
    
  end

  def self.all
    @@all
    
  end
end

