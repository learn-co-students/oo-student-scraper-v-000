class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|k, v| self.send("#{k}=", v)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |a, v|
      self.send("#{a}=", v)
    end
  end

  def self.all
    @@all
  end
end
