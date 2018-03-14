class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |a, v|
      self.send("#{a}=", v)
    end

    @@all << self

  end

  def self.create_from_collection(students_array)
    students_array.each do |h|
      Student.new(h)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |a, v|
      self.send("#{a}=", v)
    end
    self
  end

  def self.all
    @@all 
  end
end
