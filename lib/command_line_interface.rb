require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

class CommandLineInterface
  BASE_PATH = "./fixtures/student-site/"

  def run
    make_students
    add_attributes_to_students
    display_students
  end

  def make_students
    students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
  #calls #scrape_index_page on Scraper class to scrape student name, location
  #and profile link from student site and stores all info on stuents_array variable
    Student.create_from_collection(students_array)
  #calls #create_from_collection to create a new instances of the Student class using
  #the students_array data scraped from student site. saves each instance in the @@all student class variable.

  end

  def add_attributes_to_students
    Student.all.each do |student| # iterates through each instane of Student class
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
  # calls #scrape_profile_page on Scraper class to scrape student info from each
  #student profile link and saves the info in attributes hash variable.
      student.add_student_attributes(attributes)
  # calls #add_student_attritubes on each instance of a student class to add the
  # additional information retrevied from their profile link.
    end
  end

  def display_students
    Student.all.each do |student| #iterates through each instance of student class
      puts "#{student.name.upcase}".colorize(:blue) # formats and prints Student name in all caps and blue font
      puts "  location:".colorize(:light_blue) + " #{student.location}" # puts header "location" in blue and student location info in default color.
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}" #prints header "profile quote" in blue and student profile quote in default color.
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}" # all above code prints header for student info in blue and info in default color.
      puts "----------------------".colorize(:green) # prints a green border to divide and organize student profile info. 
    end
  end

end
