class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each{|a,b| self.send("#{a}=", b)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each{|e| self.new(e)}
    
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|a,b| self.send("#{a}=", b)}
    self 
  end

  def self.all
    @@all 
  end
end

