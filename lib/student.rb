class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    new_from_collection(students_array).save
  end

  def self.new_from_collection(hash)
    student = self.new
    student.name = hash[:name]
    student.location = hash[:location]
    student
  end

  def save
    @@all << self
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end
end
