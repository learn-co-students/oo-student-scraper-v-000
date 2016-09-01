require_relative "../lib/scraper.rb"
require_relative "../lib/student.rb"
require 'nokogiri'
require 'colorize'

#We've given you a third class, `CommandLineInterface` that is responsible for generating students using both the `Student` and `Scraper` classes. As you go through this lab, take some time to read through the code in the `CommandLineInterface` class. Try to understand how it works and how it uses the code in our other classes to actually create, add attributes, and display students to the user via the command line interface.

class CommandLineInteface
  BASE_PATH = "./fixtures/student-site/"

  def run
    make_students
    add_attributes_to_students
    display_students
  end

  def make_students
    students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
    Student.create_from_collection(students_array)
  end

  def add_attributes_to_students
    Student.all.each do |student|
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
