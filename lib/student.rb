class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  # def initialize(attributes)
  #   attributes.each {|key, value| self.send(("#{key}="), value)}
  # end

  def self.create_from_collection(students_array)
    student = Student.new
    student.send("#{method_name}=", value)
  end

  def add_student_attributes(attributes_hash)

  end

  def self.all

  end
end
