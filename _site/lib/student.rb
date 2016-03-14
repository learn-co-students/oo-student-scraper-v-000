require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    @student_hash = student_hash
    @student_hash.each do |key,value| 
      self.send(("#{key}="), value)
      @@all<<self
    end

    
  end

  def create_from_site(url)
    students = Scraper.scrape_from_index_page(url)
    self.create_from_collection(students)
  end


  def self.create_from_collection(array)
 
    array.each do |hash|
      self.new(hash)
    end
  end
    
    
  

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key,value|
      self.send(("#{key}="), value)
    end
    
  end

  def self.all
    
  end
end

