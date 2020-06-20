class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self #self is an object of a student

  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash)
#binding.pry
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
#binding.pry

  end

  def self.all
    @@all 

  end
end
