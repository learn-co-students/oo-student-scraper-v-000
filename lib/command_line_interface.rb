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
      puts "#{student.name.upcase}".colorize(:green)
      puts "  location:".colorize(:green) + " #{student.location}"
      puts "  profile quote:".colorize(:green) + " #{student.profile_quote}"
      puts "  bio:".colorize(:green) + " #{student.bio}"
      puts "  twitter:".colorize(:green) + " #{student.twitter}"
      puts "  linkedin:".colorize(:green) + " #{student.linkedin}"
      puts "  github:".colorize(:green) + " #{student.github}"
      puts "  blog:".colorize(:green) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end
