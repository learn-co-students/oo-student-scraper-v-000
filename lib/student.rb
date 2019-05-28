require_relative '../lib/scraper.rb'
require 'pry'

class Student

  attr_accessor :name, :location, :profile_url, 
      :twitter, :linkedin, :github, :blog, :profile_quote, :bio
  @@all = []

# Example metaprogramming lesson as guide: 
#  https://tinyurl.com/metaprog-example

  # .initialize called by .create_from_collection method
  # assigns attributes: @name, @location, @profile_url
  # and adds new objects to @@all collection
  def initialize(student_hash)
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end

# .create_from_collection
# uses scraped data from Scraper.scrape_index_page method
  def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      Student.new(student_hash) #initializes student object
    end  
  end
 
# .add_student_attributes
# uses second layer scraped data from Scraper.scrape_profile_page
# of individual student profile to find social media, quote & bio
# attributes
  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  end
end # class end