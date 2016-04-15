class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url, :facebook, :youtube, :instagram

  @@all = []

  def initialize(student_hash)
    student_hash.each do |key, value|
      self.send "#{key}=" , value
    end
    @@all << self
  end

  # use array such as output from Scraper.scrape_index_page
  def self.create_from_collection(students_array)
    students_array.each do |student_basics_hash|
      Student.new(student_basics_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send "#{key}=" , value
    end
    self
  end

  def self.all
    @@all
  end
end
