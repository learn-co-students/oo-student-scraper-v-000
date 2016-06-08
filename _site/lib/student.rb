class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value| 
      self.send(("#{key}="), value)
    end
    @@all << self
    
  end



  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
    
    #student_profile = "http://127.0.0.1:4000/#{student.css("a")[0]['href']}"
    #student_name = student.css(".student-name").text
    #student_location = student.css(".student-location").text
    #students << {name: student_name, location: student_location, profile_url: student_profile}


  end

  def add_student_attributes(attributes_hash)

    attributes_hash.each do |key, value| 
      self.send(("#{key}="), value)
    end

    #student_info[:twitter] = link
    #student_info[:github] = link
    #student_info[:linkedin] = link
    #student_info[:blog] = link
    #student_info[:profile_quote] = quote
    #student_info[:bio] = bio
    
  end

  def self.all
    @@all
    
  end
end

