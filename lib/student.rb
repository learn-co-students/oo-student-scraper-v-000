class Student

  #we don't want our Student model to be dependent on how it gets information regarding 
  #the students it creates

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each{|key, value| self.send("#{key}=", value)}
    @@all << self
  end

  def self.create_from_collection(students_array)
    #The #create_from_collection method should iterate over the array of hashes and create 
    #a new individual student using each hash
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
    
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send("#{key}=", value)}
  end

  def self.all
    @@all
  end
end

