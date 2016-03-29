#require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
 
  student_hash.each do |k, v|
    self.send "#{k}=", v
  end

  @@all << self

  end

  def self.create_from_collection(students_array)

    students_array.each do |e|

      student = Student.new(e)
    end 
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      self.send "#{k}=", v
    end
    
  end

  def self.all
    @@all
  end

<<<<<<< HEAD
end


#Student.create_from_collection(Scraper.scrape_index_page("http://127.0.0.1:4000"))


  

=======
end


#Student.create_from_collection(Scraper.scrape_index_page("http://127.0.0.1:4000"))


=begin
  
rescue Exception => e
  
end

    student = Student.new
    students_array.each do |student|
      student.send("name=", student[:name])
      student.send("location=", student[:location])
      student.send("profile_url=", student[:profile_url])

=end      
>>>>>>> 020dfffa837c875ff389186739eb371f86007f75
