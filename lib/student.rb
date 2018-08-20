require 'pry'
require 'scraper.rb'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    @name = student_hash[:name]
    @location = student_hash[:location]
    @profile_url = student_hash[:profile_url]
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      new_s = Student.new(student)
      new_s.add_student_attributes(Scraper.scrape_profile_page('./fixtures/student-site/' + new_s.profile_url.to_s))
    end
  end

  def add_student_attributes(attributes_hash)
    self.twitter = attributes_hash[:twitter].to_s
    self.linkedin = attributes_hash[:linkedin].to_s
    self.github = attributes_hash[:github].to_s
    self.blog = attributes_hash[:blog].to_s
    self.profile_quote = attributes_hash[:profile_quote].to_s
    self.bio = attributes_hash[:bio].to_s
  end

  def self.all
    @@all
  end
  binding.pry
end
