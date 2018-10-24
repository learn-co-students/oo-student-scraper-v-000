require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
   index_page = Nokogiri::HTML(open(index_url))
   
   scraped_students = [] 
   
   #roster = index_page.css(".roster-card-container")
   #name = index_page.css("h4.student-name").text
   #location = index_page.css(".student-location").text 
   #profile_url = index_page.css("div.student-card a").map { |link| link['href'] }
 
 index_page.css("div.roster-cards-container").each do |card|
      student = {
   #:name => card.css(".student-name").text, 
    :name => card.css("h4.student-name")[0].text , 
    :location => card.css(".student-location")[0].text, 
    :profile_url => card.css("div.student-card a")[0].values 
   }
    
    scraped_students << student 
    end 
  scraped_students
  end

  def self.scrape_profile_page(profile_url)
  
  profile_page = Nokogiri::HTML(open(profile_url))
  
   #twitter: profile_page.css("div.social-icon-container a")[0].values
   #linkedin: profile_page.css("div.social-icon-container a")[1].values
   #github: profile_page.css("div.social-icon-container a")[2].values
   #blog:  
   #profile_quote: profile_page.css("div.profile-quote").text 
   #bio: profile_page.css("div.description-holder p").text 
    scraped_student = {}
    profile_page.css("div.vitals-container").each do |details|
      
      scraped_student = {
        :twitter => details.css("div.social-icon-container a")[0].attribute("href").value, 
        :linkedin => details.css("div.social-icon-container a")[1].attribute("href").value, 
        :github => details.css("div.social-icon-container a")[2].attribute("href").value,
        :blog => details.css("div.social-icon-container a")[3].attribute("href").value,
        :profile_quote => details.css("div.profile-quote").text, 
        :bio => details.css("div.description-holder p").text 
      }
    
   end
  scraped_student
  end

end