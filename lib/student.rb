class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @@all << self
  end

  def self.create_from_collection(students_array) #this is an array of student hashes
    students_array.each do |student|
      new_s = Student.new(student) #you pass in the hash as an argument to instantiate a Student object.
    end

  end

  def add_student_attributes(attributes_hash) #this is the hash collected from the scrape_profile_page scraper method.
    self.twitter = attributes_hash[:twitter]
    self.linkedin = attributes_hash[:linkedin]
    self.github = attributes_hash[:github]
    self.blog = attributes_hash[:blog]
    self.profile_quote = attributes_hash[:profile_quote]
    self.bio = attributes_hash[:bio]
    self.profile_url = attributes_hash[:profile_url]
  end

  def self.all
    @@all
  end
end
