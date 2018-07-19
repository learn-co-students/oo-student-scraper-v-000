require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  
  
   def self.scrape_index_page(index_url)
      doc = Nokogiri::HTML(open(index_url)) 
      student_scrape = []
      
      doc.css("div.student-card").each do |student| 
    
        student_scrape << { 
          :name => student.css("h4.student-name").text,  
          :location => student.css("p.student-location").text,
          :profile_url =>   student.css("a").attribute("href").value
                           }
          end 
      student_scrape
  end
 
  
def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    
    
    student_page = {}
  
    doc.css("div.social-icon-container a").each do |link| 
        
      if link.include?("twitter")
       student_page[:twitter] = link["href"]
       
      elsif link.include?("linkedin") 
       student_page[:linkedin] = link["href"]
   
      elsif link.include?("github")
       student_page[:github] = link["href"]
    end 
     
     student_page[:profile_quote] = doc.css("div.profile-quote").text if doc.css("div.profile-quote")
    student_page[:bio] = doc.css("div.description-holder").text if doc.css("div.description-holder") 
     

 end 
  student_page
  end 






end

