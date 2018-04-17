require 'open-uri'
require 'pry'

class Scraper

   def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
    student_info = doc.css(".student-card")
    student_info.each do |student|
      students_array << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: student.css("a").attribute("href").value
        }
    end
    students_array
   end
  
 	 
   def self.scrape_profile_page(profile_url)	  
    	    doc = Nokogiri::HTML(open(profile_url))
    social_sites = {}
    social_media = doc.css(".social-icon-container a")
    social_media.each do |social_media_site|
      link = social_media_site.attribute('href').value
      if link.include?("twitter")
        social_sites[:twitter] = link
      elsif link.include?("linkedin")
        social_sites[:linkedin] = link
      elsif link.include?("github")
        social_sites[:github] = link
      else
        social_sites[:blog] = link
      end
    end
    social_sites[:profile_quote] = doc.css(".profile-quote").text
    social_sites[:bio] = doc.css(".description-holder p").text

social_sites

end 

end 

    
    
    
    
    
    
    
    