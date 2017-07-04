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
      attributes = Scraper.scrape_profile_page(student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}" if student.location != ""
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}" if student.profile_quote != ""
      puts "  bio:".colorize(:light_blue) + " #{student.bio}" if student.bio != ""
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}" if student.twitter != nil
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}" if student.linkedin != nil
      puts "  github:".colorize(:light_blue) + " #{student.github}" if student.github != nil
      puts "  blog:".colorize(:light_blue) + " #{student.blog}" if student.blog != nil
      puts "----------------------".colorize(:green)
    end
  end

end
