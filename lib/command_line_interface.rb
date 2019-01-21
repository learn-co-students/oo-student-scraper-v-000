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
    Student.create_from_collection(students_array)
  end

  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  Location:".colorize(:light_blue) + " #{student.location}"
      puts "  Profile Quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  Bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  Twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  Linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  Github:".colorize(:light_blue) + " #{student.github}"
      puts "  Blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end
