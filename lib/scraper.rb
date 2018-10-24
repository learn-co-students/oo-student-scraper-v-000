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
    
    links = profile_page.css("div.social-icon-container").children.css("a").map {|element| element.attribute("href").value}
    
    links.each do |link|
      if link.include?("twitter")
        scraped_student[:twitter] = link 
      elsif link.include?("github")
        scraped_student[:github] = link
        elsif link.include?("linkedin")
        scraped_student[:linkedin] = link 
      else 
        scraped_student[:blog] = link
      end
    end 
    
        scraped_student[:profile_quote] = profile_page.css("div.profile-quote").text if profile_page.css("div.profile-quote")
        
        scraped_student[:bio] = profile_page.css("div.details-container .description-holder p").text if profile_page.css("div.details-container .description-holder p")
      
  scraped_student
  end

end