class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
   self.name = student_hash[:name]
   self.location = student_hash[:location]
   self.class.all << self
  end


  def self.create_from_collection(students_array)
    Scraper.scrape_index_page(students_array)
  end

  def add_student_attributes(attributes_hash)
    
  end

  def self.all
    @@all
  end
end

