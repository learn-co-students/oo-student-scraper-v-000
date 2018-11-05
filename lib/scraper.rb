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
    

  def self.scrape_profile_page(profile_url) 
      
      profile_page = Nokogiri::HTML(open(profile_url))
      student_profile = {}
       
       #binding.pry
       
      links = profile_page.css("div.main-wrapper.profile.social-icon-container a").each do |social|
        if social.attribute("href").value.include? (twitter") 
          student_profile[:twitter] = social.attribute("href").value 
        
        if social.attribute("href").value.include?("linkedin") 
          student_profile[:linkedin] = social.attribute("href").value 
        
        if social.attribute("href").value.include? ("github") 
          student_profile[:github] = social.attributes("href").value 
          
        if social.attribute("href").value.include? ("blog_url") 
          student_profile[:blog_url] = social.attributes("href").value 
          
        if social.attribute("href").value.include?("profile_quote")
          student_profile[:profile_quote] = social.attributes("href").value 
          
        
    
      
      
      end
 
  end

end 
    

    
   
 


