class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    #@name = student_hash[:name]
    self.send("name=", student_hash[:name])
    #@location = student_hash[:location]
    self.send("location=", student_hash[:location])
    #@profile_url = student_hash[:profile_url]
    self.send("profile_url=", student_hash[:profile_url])
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student_hash| #each student is a hash
      Student.new(student_hash)
    end

  end

  def add_student_attributes(attributes_hash)
    self.send("twitter=", attributes_hash[:twitter])
    self.send("linkedin=", attributes_hash[:linkedin])
    self.send("github=", attributes_hash[:github])
    self.send("blog=", attributes_hash[:blog])
    self.send("profile_quote=", attributes_hash[:profile_quote])
    self.send("bio=", attributes_hash[:bio])
  end

  def self.all
    @@all
  end


end
