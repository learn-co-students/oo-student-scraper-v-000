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
      student_profile_url = "#{student.attr('href')}" # The href attribute provides address information for    
    
      profile_url = "#{student.attr('href')}" # The href attribute provides addresss information for links
      
      #student_profile_url = "students/#{student_name.gsub(' ', '-').downcase}.html"
        
        students << {name: student_name, 
        location: student_location, 
        profile_url: student_profile_url
        }
                end   
            end
        students
    end
    

  def self.scrape_profile_page(profile_url) 
      
      profile_page = Nokogiri::HTML(open(profile_url))
      flatiron_profile_url = {}
       
       
      profile_page.css("div.main-wrapper.profile.social-icon-container a").each do |social|
        if social.attribute("href").value.include? ("twitter") 
          flatiron_profile_url[:twitter] = social.attribute("href").value 
        
       
        elsif social.attribute("href").value.include?("linkedin") 
          flatiron_profile_url[:linkedin] = social.attribute("href").value 
        
        elsif social.attribute("href").value.include? ("github") 
          flatiron_profile_url[:github] = social.attribute("href").value 
            
        else 
    
          flatiron_profile_url[:blog] = social.attribute("href").value 
        
        end
      end 
        
       
        flatiron_profile_url[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile_quote")
        flatiron_profile_url[:bio] = profile_page.css("p").text
        #binding.pry
        flatiron_profile_url 
        #profile_page
        #scrape_profile_page(profile_url) 
      end
        flatiron_profile_url
end 
        
          
        
    
      
    