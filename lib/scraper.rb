require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    
    doc = Nokogiri::HTML(open(index_url))
    students = []
     
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text 
        student_location = student.css('.student-location').text 
        student_profile_url = ???
        
        students << {name: student_name, 
        location: student_location, 
        profile_url: student_profile_link
        }
          end
      end
      students
end   
    
                   
  
 



