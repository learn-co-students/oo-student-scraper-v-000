require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    html=Nokogiri::HTML(open(index_url))
   
    array_of_hashes=[]
    
    html.css(".student-card").each do |student|
      hash={}
      hash[:name]=student.css(".student-name").text
      hash[:location]=student.css(".student-location").text
      hash[:profile_url]= "http://students.learn.co/"+student.css("a").attribute("href").value
      array_of_hashes << hash
        end
    array_of_hashes
  end

  def self.scrape_profile_page(profile_url)
    html=Nokogiri::HTML(open(profile_url))
   hash={}
    html.css(".social-icon-container").css("a").each do |social_media_type|
      if social_media_type.attribute("href").value.include?("twitter")
        hash[:twitter]=social_media_type.attribute("href").value
      elsif social_media_type.attribute("href").value.include?("linkedin")
        hash[:linkedin]=social_media_type.attribute("href").value
      elsif social_media_type.attribute("href").value.include?("github")
        hash[:github]=social_media_type.attribute("href").value
      else
        hash[:blog]=social_media_type.attribute("href").value
      end
                                                  end
      hash[:profile_quote]=html.css(".profile-quote").text
      hash[:bio]=html.css(".bio-block").css("p").text
    #html.css(".social-icon-container").css("a").attribute("href").value
    hash
    
  end
end

