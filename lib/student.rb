class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    
      #binding.pry
      #@name = student_hash[:name]
      #@location = student_hash[:location]

      student_hash.each {|key, value|
        self.send(("#{key}="), value)}
      @@all << self
    

  end

  def self.create_from_collection(students_array)
  
    students_array.each do |h| Student.new(h)
    end  
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value)
      #binding.pry
    end
    self
  end

  def self.all
    @@all
  end
end

