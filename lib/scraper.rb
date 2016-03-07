require 'pry'
require 'open-uri'
require 'nokogiri' 

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.roster-cards-container").each do |student| 
        binding.pry
        
       name = student.css(".student-name").text,
       location = student.css(".student-location").text, 
       profile_url = "http://127.0.0.1:4000/#{student.css("a").first["href"]}"
    students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end
