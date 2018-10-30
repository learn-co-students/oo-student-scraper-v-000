class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    #This method is useful for when you can't guarantee how many keys your argument hash contains. Rather than manually having to code @twitter = student_hash[:twitter]
    student_hash.each do |key, value| 
      self.send "#{key}=", value
    end
    @@all << self
    
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send "#{key}=", value
    end
    self
  end

  def self.all
    @@all
  end
end

