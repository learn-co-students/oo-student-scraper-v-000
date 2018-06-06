class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  
  def self.all
    @@all
  end
  
  
  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end
  

  def self.create_from_collection(student_index_array)
    student_index_array.each do |hash|
      self.new(hash)
    end
  end


  def add_student_attributes(hash)
    hash.each {|key, value| self.send(("#{key}="), value)}
  end

end