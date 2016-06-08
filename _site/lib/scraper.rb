require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    index.css(".student-card a")
    students = []

    index.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_link = "http://127.0.0.1:4000/#{student.attr('href')}"
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
     binding.pry
     
      end
    end
  end






  def self.scrape_profile_page(profile_url)
    
  end

end

