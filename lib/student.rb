class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)} #use send method to keep the program flexible so any student can be displayed.
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |hash| #iterate over array of hashes while creating a new student.
      Student.new(hash)
  end
end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)} #use send method to keep the program flexible so any student can be displayed.
    @@all << self
  end

  def self.all
    @@all #returns all the contents of @@all array

  end
end
