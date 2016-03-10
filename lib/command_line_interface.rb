require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInteface
  BASE_URL = "http://127.0.0.1:4000/"

  def run
    make_students
    add_attributes_to_students
    display_students
  end

  def make_students
    #First, in Scraper class
    #scrape the entire page and return an array of hashes, where each hash is a student profile (name/location/url)
    students_array = Scraper.scrape_index_page(BASE_URL)
    #Second, in Student class
    #use that array as an input and create new students
    #each student hash becomes the key/value attributes
    #each student is pushed into the @@all of Students 
    Student.create_from_collection(students_array)
  end

  def add_attributes_to_students
    #Iterate over @@all of Students
    Student.all.each do |student|
      #Second, in Scraper class, 
      #use the student profile_url as an input by getting it from student.profile_url
      #return the student-specific attributes in a hash
      #use hash to create new key/value attributes
      attributes = Scraper.scrape_profile_page(student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}"
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end
