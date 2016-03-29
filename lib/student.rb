class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    self.send("name=", self[:name])
    self.send("location=", self[:location])
    self.send("profile_url=", self[:profile_url])

    @@all << self
    
  end

  def self.create_from_collection(students_array)
    students_array.each do |e|
      e = Student.new
    end   
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end

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
