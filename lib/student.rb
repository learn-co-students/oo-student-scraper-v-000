class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    #should this call on #add_student_attibutes?
    student_hash.each do |key, value|
      self.send(("#{key}="), value)
      #name of the key becomes our setter method
      #the value becomes the value of the setter method
      #self.send(key=,value)
      #same as instance.key= value
    end
    add_student_attributes(student_hash)
    self.class.all << self
  end

  def self.create_from_collection(students_array)
    #is this even part of the test suite?
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send(("#{key}="), value)
      #name of the key becomes our setter method
      #the value becomes the value of the setter method
      #self.send(key=,value)
      #same as instance.key= value
    end
  end

  def self.all
    @@all
  end
end

