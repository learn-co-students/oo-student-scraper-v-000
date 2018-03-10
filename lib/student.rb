class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, val|
      self.send("#{key}=", val)
    end
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|x| Student.new(x)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attribute, val|
      self.send("#{attribute}=", val)
    end
    self
  end

  def self.all
    @@all
  end
end
