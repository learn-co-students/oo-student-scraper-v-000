require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  html = File.read('./fixtures/student-site/index.html')
   scraped_students = Nokogiri::HTML(html) 
   students = []
   scraped_students.css("div.roster-cards-container").each do |student, value|
      students << student[value] = {}
     #binding.pry
   end 
  
    
  end

  def self.scrape_profile_page(profile_url)
   #.css("div.student-card") css.("a").attribute("href") 
  end

end

