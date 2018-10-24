require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
   index_page = Nokogiri::HTML(open(index_url))
   
   scraped_students = [] 
   
  index_page.css("div.roster-cards-container").each do |card|
    card.css("div.student-card a").each do |student|
      student = {
    :name => student.css("h4.student-name").text, 
    :location => student.css("p.student-location").text, 
    :profile_url => student.attribute("href").value
   }
    scraped_students << student
    end 
  end 
  scraped_students
  end

  def self.scrape_profile_page(profile_url)
  
    profile_page = Nokogiri::HTML(open(profile_url))
   
    scraped_student = {}
    
        scraped_student[:twitter] = profile_page.css("div.social-icon-container a")[0].attribute("href").value if profile_page.css("div.social-icon-container a")[0].attribute("href").value
        
        scraped_student[:linkedin] = profile_page.css("div.social-icon-container a")[1].attribute("href").value if profile_page.css("div.social-icon-container a")[1].attribute("href").value
        
        scraped_student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value
        
        scraped_student[:blog] = profile_page.css("div.social-icon-container a")[3].attribute("href").value if profile_page.css("div.social-icon-container a")[3].attribute("href").value
        
        scraped_student[:profile_quote] = profile_page.css("div.profile-quote").text 
        
        scraped_student[:bio] = profile_page.css("div.details-container .description-holder p").text 
      
  scraped_student
  end

end