class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each  {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    Student.create_from_collection
  end

  def add_student_attributes(attributes_hash)
    Student.add_student_attributes
  end

  def self.all
    @@all << self
  end
end

