require 'pry'
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    Student.new(student_hash).tap do |student|
      student_hash.each do |k,v|
        student.send("#{k}=", v)
      end
    end
    @@all << self
    binding.pry
  end

  def self.create_from_collection(students_array) #argument is array of hashes return value of Scraper.scrape_index_page

  end

  def add_student_attributes(attributes_hash)

  end

  def self.all
    @@all
  end
end
