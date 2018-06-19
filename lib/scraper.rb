require 'open-uri'
require 'pry'
#name = doc.css(".student-card").css("h4").text
#location = doc.css(".student-card").css("p").text
class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = {}
    doc.css(".student-card").each do|scrape|
     students = {
      name: "scrape.css("h4").text",
      location: "scrape.css("p").text",
     }
      #binding.pry
    end
    students
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

