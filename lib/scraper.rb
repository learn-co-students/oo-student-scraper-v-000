require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    
    hash_array = []
    doc.css(".student-card").each do |card|
      hash_array << { 
        :name => card.css("h4").children.text,
        :location => card.css("p").children.text,
        :profile_url => card.css("a").attribute("href").value
      }
      end
    hash_array
    end
    

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    hash = {}
    
   social_array = doc.css(".social-icon-container a").collect { |n|
      n.attribute("href").value
    }
    social_array.each do |s|
      if s.include?("twitter")
        hash[:twitter] = s
      elsif s.include?("linkedin")
        hash[:linkedin]= s
      elsif s.include?("github")
        hash[:github] = s
      elsif s.include?("youtube")
        hash[:youtube] = s
      elsif s.include?("facebook")
        hash[:facebook] = s
      else hash[:blog] = s
      end
    end
      
      hash[:profile_quote] = doc.css("div.profile-quote").text
 
      hash[:bio] = doc.css("div.bio-content.content-holder p").text
    hash
  end

end



