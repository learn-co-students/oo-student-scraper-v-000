require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
   index_page = Nokogiri::HTML(open(index_url))
   
   scraped_students = [] 
   
  index_page.css("div.roster-cards-container").each do |card|
    card.css("").each do |student|
      student = {
    :name => student.css("h4.student-name").text, 
    :location => student.css(".student-location").text, 
    :profile_url => student.css("div.student-card a").attribute("href").value
   }
    scraped_students << student 
    end 
  scraped_students
  end

  def self.scrape_profile_page(profile_url)
  
    profile_page = Nokogiri::HTML(open(profile_url))
   
    scraped_student = {}
    
    profile_page.css("body").each do |details|
      scraped_student = {
        :twitter => details.css("div.social-icon-container a")[0].attribute("href").value, 
        :linkedin => details.css("div.social-icon-container a")[1].attribute("href").value, 
        :github => details.css("div.social-icon-container a")[2].attribute("href").value,
        :blog => details.css("div.social-icon-container a")[3].attribute("href").value,
        :profile_quote => details.css("div.profile-quote").text, 
        :bio => details.css("div.details-container .description-holder p").text 
      }
   end
   
  scraped_student
  end

end