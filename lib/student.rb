class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, val|
      self.send(("#{key}="), val)
    }
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|hash|
      Student.new(hash)
    }
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, val|
      self.send(("#{key}="), val)
    }
  end

  def self.all
    @@all
  end
end

