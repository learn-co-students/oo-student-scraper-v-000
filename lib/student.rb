class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end
  

  def new(arg)
    student = Self.new
    student.name = arg[:name]
    student.location = arg[:location]
 
    @@all << student
  end

  def self.create_from_collection(students_ary)
     students_ary.each do |student|
      new_student = self.new(student)
      self.all << new_student
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end

