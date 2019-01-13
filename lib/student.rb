require "pry"
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(scraped_student)
   @name = scraped_student[:name]
   @location = scraped_student[:location]
   @@all << self
   
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end 
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |detail|
     #binding.pry
     if detail.include?(:twitter)
        @twitter = attributes_hash[:twitter]
      elsif detail.include?(:linkedin)
        @linkedin = attributes_hash[:linkedin]
      elsif detail.include?(:github)
        @github = attributes_hash[:github]
      elsif detail.include?(:blog)
        @blog = attributes_hash[:blog]
      elsif detail.include?(:profile_quote)
        @profile_quote = attributes_hash[:profile_quote]
      elsif detail.include?(:bio)
        @bio = attributes_hash[:bio]
      elsif detail.include?(:profile_url)
        @profile_url = attributes_hash[:profile_url]
      end
    end
  end

  def self.all
    @@all
  end
end

