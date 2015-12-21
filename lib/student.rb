class Student
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url
  @@all = []

  def initialize(student_hash)
    student_hash.each { |key, value| self.send(("#{key}="), value) } #uses metaprogramming and mass assignment to assign all the values in the hash to this student object via the self.send method
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |i| #iterates over the array of students and creates a new student for each hash in the array
      student = Student.new(i)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each { |key, value| self.send(("#{key}="), value) } #uses metaprogramming and mass assignment to assign all the values in the hash to this student object via the self.send method
    self #returns the self Student object
  end

  def self.all
    @@all
  end
end