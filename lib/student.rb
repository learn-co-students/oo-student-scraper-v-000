class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #sets students attributes using the key/value pairs of that hash
    student_hash.each do |attribute,value|
      self.send("#{attribute}=",value)
    end
    @@all << self # adds that new student to the student class
  end

  def self.create_from_collection(students_array) #creating a new student with the info from the student array
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash) # to get a hash of a given students attributes
    attributes_hash.each do |attribute, value|
      self.send("#{attribute}=",value)
    end
  end

  def self.all
    @@all
  end
end
