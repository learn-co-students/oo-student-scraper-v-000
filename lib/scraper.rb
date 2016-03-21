require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper



  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
      name = student.css(".student-name").text.strip
      location = student.css(".student-location").text.strip
      link = "http://127.0.0.1:4000/#{student.attr('href')}"
      students << {name: name, location: location, profile_url: link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end


end

