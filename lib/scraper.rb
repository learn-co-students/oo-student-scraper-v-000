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
          :profile_url => student.css("a").attribute("href").value
                           }
          end 
      student_scrape
  end
 
  
  
  def self.scrape_profile_page(profile_url)
    
  end

end

