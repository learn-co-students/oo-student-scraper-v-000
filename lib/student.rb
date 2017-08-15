class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash) #=> <<student_hash>> = {:name=>"Alex Patriquin", :location=>"New York, NY"}
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(students_array) #=> <<students_array>> = [{:name=>"Alex Patriquin", :location=>"New York, NY"}, ... {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"}]
    # First you have to iterate over the array of hashes and send each one to the initialize method.
    students_array.each do |info|
      Student.new(info)
    end
#    students_array.each do |key, value|
#      x = Student.new
#      key = x.name,
#      value = x.location
#    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end
