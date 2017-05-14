
class Student
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]  # gets the name from the hash
    @location = student_hash[:location] #gets the location from the hash
    @@all << self #adds the student to the all variable
  end

  def self.create_from_collection(students_array)
    students_array.each{|student_hash| self.new(student_hash)}
    #creates an obj with each elementary on the array with consist of hashes
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|k,v| self.instance_variable_set("@#{k}".to_sym, v) }
    #sets the value based on the instance name matching the key.
  end

  def self.all
    @@all
  end
end
