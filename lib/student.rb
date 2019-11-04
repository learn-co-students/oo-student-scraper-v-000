require 'pry'

class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = [ ]

  BASE_PATH = "./fixtures/student-site/"

  index_url = BASE_PATH + 'index.html'

  profile_url = BASE_PATH + 'students/'

  students_array = Scraper.scrape_index_page(index_url)

  def initialize(student_hash)
    student_hash.each do |key,value|
      self.send("#{key}=", value)
    end
    @@all << self
  end


  def self.create_from_collection(students_array)
          students_array.each do |student_hash|
            self.new(student_hash)
          end
      end


  def add_student_attributes(attributes_hash)
          attributes_hash.each do |key,value|
          self.send("#{key}=", value)
        end
        self
  end

  def self.all
    @@all
  end

end
