class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
     student_hash.each do |key,value|
     self.send("#{key}=", value)
     end
     @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      self.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    student_attributes = self.instance_variables
    attributes_hash.each do |key, value|
      if student_attributes.none?{|attribute| attribute == "#{key}"}
        self.send("#{key}=", value)
      end
    end
  end

  def self.all
    @@all
  end
end
