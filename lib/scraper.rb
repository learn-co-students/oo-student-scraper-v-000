require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
    student = {}
    student[:name] = doc.css("h1#profile-name").text
    student[:location] = doc.css("h2#profile-location").text
    student[:profile_url] = doc.css("div#student-card a href").text
         binding.pry    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

