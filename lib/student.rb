class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @student_hash = student_hash
    self.name = @student_hash[:name]
    self.location = @student_hash[:location]
    self.profile_url =@student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each{|student|
      newstudent = self.new(student)
    }
    
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|key, value|
      self.send(("#{key}="), value)
      #self.send(all, student[:twitter], student[:linkedin], student[:github], student[:blog], student[:profile_quote], student[:bio])
    }
    self
  end

  def self.all
    @@all
  end
end

