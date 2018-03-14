class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.map do |attr, value|
      self.send("#{attr}=", value)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.map do |student|
      Student.new(student)
    # binding.pry
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.map do |attr, value|
      self.send("#{attr}=", value)
    end
  end

  def self.all
    @@all
  end
end
