class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array)
    
    students_array.each do |student|
      new_student_hash = {}
      new_student_hash[:name] = student[:name]
      new_student_hash[:location] = student[:location]
      Student.new(new_student_hash)
    end
    
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.all
    @@all
  end
end

