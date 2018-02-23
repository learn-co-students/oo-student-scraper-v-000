require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInteface
  BASE_PATH = "./fixtures/student-site/"

  def run
    make_students
    add_attributes_to_students
    display_students
  end

  def make_students
    #students_array will return the scraped/parsed index page of all students
    #it returns the nokogiri object(array thing)
    students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
    #this creates the student instances with the following attributes: :name, :location, :profile_url
    Student.create_from_collection(students_array)
  end

  def add_attributes_to_students
    #this goes through each student in @@all array
    #scrapes the profile page of each student and returns a hash for each student
    #attributes is equal to the hash for an indiviudal student
    #then the hash is fed into the add_student_attributes method
    #which assigns the attributes to the individual student
    #those attributes are: twitter url, linkedin url, github url, blog url, profile quote, bio
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
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
