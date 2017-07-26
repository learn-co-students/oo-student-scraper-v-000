class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
      #lets enumerate over the hash, and for each hash value lets set it to a attr_accessor variable
      student_hash.each {|attribute, value| self.send("#{attribute}=", value)}
      #add the student to the @@all class array
      @@all << self
  end

  def self.create_from_collection(students_array)
    #given an array of hashes, setup new students using the initialize method. So for each student hash, plug it into our initialize method
      students_array.each {|student_hash| Student.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
      attributes_hash.each {|student_attribute, value| self.send("#{student_attribute}=", value)}
  end

  def self.all
      @@all
  end
end
