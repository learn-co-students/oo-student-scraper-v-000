class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
  end

  def self.create_from_collection(students_array)
    students_array.each do |f|
      Student.new([f[:name], f[:location]])
    end

      # let!(:student) {Student.new({:name=>"Alex Patriquin", :location=>"New York, NY"})}
    # {:name=>"Joe Burgess", :location=>"New York, NY", :profile_url=>"http://students.learn.co/students/joe-burgess.html"}
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    
  end
end

