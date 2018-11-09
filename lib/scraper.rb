require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url


  def self.scrape_index_page(index_url)
      students = []
      html = open(index_url)
      index = Nokogiri::HTML(html)
      student_card = index.css(".student-card a")
      #student_name = student_card.css(".student-name").text
      #student_location = student_card.css(".student-location").text
      #student_url = student_card.css("a").attribute("href").text
      student_card.each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = student.css("a").attribute("href").text
        students << {name: student_name, location: student_location, profile_url: student_url}
        #binding.pry
      end
        return students
      end

    end #ends class
