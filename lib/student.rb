class Student
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
  @@all = []

  def initialize(hash)
    hash.each{|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      new(student_hash)
    end
  end

  def add_student_attributes(student_hash)
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end
end
