class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key,value|
      key = key.to_s + "="
      self.send(key, value)      
    end

    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.collect do |student_hash|
      self.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key,value|
      key = key.to_s + "="
      self.send(key, value)      
    end
  end

  def self.all
    @@all
  end
end

