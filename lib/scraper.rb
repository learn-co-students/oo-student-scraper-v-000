require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url)).css(".student-card")
    index_page.collect do |student_card|
      student = {}
      student["name"] = student_card.css(".student-name").text
      student["location"] = student_card.css(".student-location").text
      student["profile_url"] = student_card.css("a").text
    end
  end
  
  def get_index_page(index_url)

  end
  
  def scrape_student_info

  end
  
  def self.scrape_profile_page(profile_url)
    
  end

end

Scraper.scrape_index_page("http://174.138.35.103:49462/fixtures/student-site/")