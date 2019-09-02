
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  #studenthash iterating over it, and then using send method to set each attribute. like location -> ny, create from collection is iterating
  #over array of hashes and goes into initialize method and passes in a hash.
  def initialize(student_hash)
    student_hash.each do|key,value|
      self.send("#{key}=",value)
      @@all << self
    end
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do|key,value|
    self.send("#{key}=",value)
  end
    self
  end

  def self.all
    @@all
  end
end
