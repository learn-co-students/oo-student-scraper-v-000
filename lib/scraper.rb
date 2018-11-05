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
          
      
      student_profile_url = "#{student.attr('href')}" # The href attribute provides addresss information for links
      
      #student_profile_url = "students/#{student_name.gsub(' ', '-').downcase}.html"
        
        students << {name: student_name, 
        location: student_location, 
        profile_url: student_profile_url
        }
                end   
            end
        students
    end
    
 ********* 
  def self.scrape_profile_page(profile_url) 
      
      profile_page = Nokogiri::HTML(open(profile_url))
      student = {}
      
      binding.pry
      link = profile_page.css(".social-icon-container").map {|'href'|value}
      
      
      # link.each do |link| 
      #   if link.include?("twitter")
      #     :twitter => link
          
      #   if link.include?("linkedin")
      #     :linkedin => link
          
      #   if link.include?("github") 
      #     :github => link 
        
      #   if link.include?("blog_url") 
      #     :blog_url => link 
        
      #   if link.include?("profile_quote") 
      #     :profile_quote => link 
          
      #   if link.include?("bio") 
      #     :bio => link 
          
      #     end
      #     #How to code if missing a social media link
      
 
  end

end 
    

    
   
 


