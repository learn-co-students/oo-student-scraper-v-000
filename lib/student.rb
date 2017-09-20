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
    student_hash.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def self.create_from_collection(students_array)
    # take in array of hashes, make a student with each hash, which will be the argument for the init method.
    students_array.each do |student_hash|
      Student.new(student_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end

# Student.create_from_collection(Scraper.scrape_index_page("../fixtures/student-site/index.html"))
