class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|k,v| self.send("#{k}=",v)} #adds each k,v pair if there is one
    @@all << self
  end

  def self.create_from_collection(students_array)
    #input is array of hashes of students with names, location, and profile url
    #iterate over, the array and create a new student for each, with input being that student's hash of attributes
    students_array.each do |student|
      student_new = Student.new(student) #create a new student for each hash you iterate over
     end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
        self.send("#{k}=",v)
      end
  end

  def self.all
    @@all
  end

end
