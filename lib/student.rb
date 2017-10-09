class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all<<self
  end

  def self.create_from_collection(students_array) #Student .create_from_collection uses the Scraper class to create new students with the correct name and location.

  end

  def add_student_attributes(attributes_hash) #Student #add_student_attributes uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student.

  end

  def self.all #Student .all returns the class variable @@all
    @@all
  end
end
