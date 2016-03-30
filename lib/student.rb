class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(students_index_array)
    students_index_array.each do |student_hash|
      student = self.new(student_hash)    
    end   
  end

  def add_student_attributes(attributes_hash)
     attributes_hash.each {|key, value| self.send(("#{key}="), value)}
     self
  end

  def self.all
    
  end
end

