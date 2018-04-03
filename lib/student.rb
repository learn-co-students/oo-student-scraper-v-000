class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|k, v|
      send("#{k}=", v)
    }
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each {|student_hash|
      Student.new(student_hash)
    }
  end

  def add_student_attributes(attributes_hash) #adding is key here. return student itself
    attributes_hash.each {|att, val|
      self.send("#{att}=", val)
    }
    self
  end

  def self.all
    @@all
  end
end
