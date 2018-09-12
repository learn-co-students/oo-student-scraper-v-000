require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    scrape_hash = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.roster-cards-container").each do |roster_card| roster_card.css('.student-card a').each do
    |student| 
      scrape_name = student.css(".student-name").text
      scrape_location = student.css(".student-location").text
      scrape_url = student["href"]
      
      scrape_hash << {:name => scrape_name, :location => scrape_location, :profile_url => scrape_url}
    
    end
    end
    scrape_hash
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = Hash.new 
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    doc.css("div.social-icon-container a").collect do |icon|
      if icon["href"].include?("linkedin")
        profile_hash[:linkedin] = icon["href"]
      elsif icon["href"].include?("github")
        profile_hash[:github] = icon["href"]
      elsif icon["href"].include?("twitter")
        profile_hash[:twitter] = icon["href"]
      else
        profile_hash[:blog] = icon["href"]
      end
    end
  
    profile_hash[:profile_quote] = doc.css("div.profile-quote").text
    profile_hash[:bio] = doc.css("div.description-holder p").text
    
    profile_hash
  end
end
