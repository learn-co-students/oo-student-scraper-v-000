require_relative '../lib/scraper.rb'
require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

# Example metaprogramming lesson as guide: 
#  https://tinyurl.com/metaprog-example

  def initialize(student_hash)
    # use .send 
    student_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end
  
  def self.create_from_collection(students_array)
    
  end

  def add_student_attributes(attributes_hash)
    
  end

end

