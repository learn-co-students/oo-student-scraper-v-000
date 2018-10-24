require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
   index_url = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
   
   #roster = index_url.css(".student-card")
   #name = index_url.css(".student-name").text
   #location = index_url.css(".student-location").text 
   #profile_url = index_url.css("div").css(".student-card a href")
   
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

Scraper.scrape_index_page("./fixtures/student-site/index.html")

