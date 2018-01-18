class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student = self
    student_hash.each {|k,v| student.send("#{k}=", v)}
    self.class.all << student
  end

  def self.create_from_collection(students_array)
    students_array.each {|student_hash| self.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|k,v|self.send("#{k}=",v)}
    self
  end

  def self.all
    @@all
  end
end
