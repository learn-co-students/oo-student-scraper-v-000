# require 'open-uri'
# require 'nokogiri'
# require 'pry'
require_relative 'scraper.rb'


class Student

  attr_accessor :name,
                :location,
                :twitter,
                :linkedin,
                :github,
                :blog,
                :profile_quote,
                :bio,
                :profile_url

  @@all = []

  def initialize(student_hash)
    self.class.all << self
    binding.pry
  end

  def self.create_from_collection(students_array)

  end

  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end
end

Student.new(Scraper.scrape_profile_page("./fixtures/student-site/students/aaron-enser.html"))
