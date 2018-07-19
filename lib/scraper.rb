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
     binding.pry
    doc.css("div.social-icon-container").each do |students| 
     
      if students.include?("twitter")
       student_page[:twitter] = doc.css("div.social-icon-containter")[0]["href"]
      
      elsif students.include?("linkedin") 
        student_page[:linkedin] = doc.css ("div.social-icon-containter")["a"]["href"] 
    
     elsif students.include?("github")
       student_page[:github] = doc.css ("div.social-icon-containter")["a"]["href"] 
      
       end
    student_page[:profile_quote] = doc.css("div.profile-quote").text
    student_page[:bio] = doc.css("div.vitals-text-container.profile-quote").text
  
  student_page
  end 
end 
   






end

