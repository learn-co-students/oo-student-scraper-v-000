require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
  	
  	doc = Nokogiri::HTML(open(index_url))
  	students = []

   	doc.css(".student-card").each do |tag| 
   		temp_hash = {}
   		temp_hash[:"name"] = tag.css(".student-name").text
   		temp_hash[:"location"] = tag.css(".student-location").text
   		temp_hash[:"profile_url"] = tag.css("a").attribute('href').value
   		students << temp_hash
   	end

   	students

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    temp_hash = {}

    doc.css(".profile").each do |tag|

    	tag.css("div.social-icon-container").each do |a|	
    		a.css('a').each do |link|
    			key = link.attribute('href').value.match(/\btwitter\b|\blinkedin\b|\bgithub\b/)
    			if key != nil
    				temp_hash[:"#{key}"]= link.attribute('href').value
    			else
    				temp_hash[:"blog"]= link['href']
    			end
    		end	
    	end
    
    temp_hash[:"profile_quote"] = tag.css("div.profile-quote").text

    temp_hash[:"bio"] = tag.css(".bio-content .description-holder p").text

  	end
  	temp_hash
  end
end


# Scraper.scrape_profile_page(profile_url)
# # => {:twitter=>"http://twitter.com/flatironschool",
#       :linkedin=>"https://www.linkedin.com/in/flatironschool",
#       :github=>"https://github.com/learn-co,
#       :blog=>"http://flatironschool.com",
#       :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
#       :bio=> "I'm a school"
#      }
