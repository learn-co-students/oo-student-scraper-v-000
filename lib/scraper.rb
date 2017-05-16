require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_info = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").each do |stud|
        stud_name = stud.css(".student-name").text
        stud_location = stud.css(".student-location").text
        stud_profile_url = stud.css(".a href")
        students_info << {name: stud_name, location: stud_location, profile_url: stud_profile_url}

      
    end
    students_info
  end

  def self.scrape_profile_page(profile_url)

  end

end
