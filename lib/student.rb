class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :youtube, :facebook, :instagram, :nikolas, :perritano, :learn, :blog, :profile_quote, :bio, :profile_url
  # :nikolas, :perritano :: These are errors caused by Scraper.get_social using regex match for https to retrieve links
  # Should check from some common sites array to determine whether it should be admitted or not.
  
  @@all = []

  def initialize(student_hash)
    self.add_student_attributes(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each{|student_hash| Student.new(student_hash)}
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="),value)}
    self
  end

  def self.all
    @@all
  end
end
