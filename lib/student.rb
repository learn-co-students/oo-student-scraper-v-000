class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    sh = student_hash
    @name = sh[:name]
    @location = sh[:location]
    @twitter = sh[:twitter]
    @linkedin = sh[:linkedin]
    @github = sh[:github]
    @blog = sh[:blog]
    @profile_quote = sh[:profile_quote]
    @bio = sh[:bio]
    @profile_url = sh[:profile_url] 
  end

  def self.create_from_collection(students_array)
    
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    
  end
end

