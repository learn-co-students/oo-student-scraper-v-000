require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)
    student_list = []
    
      index.css(".student-card").each do |student|
        student_list <<
        {:name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value}
        
      end
    student_list
    
  end
  

  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student_page = {}
   
      profile.css(".social-icon-container a").each do |a|
        
        if (a.attribute("href").value).include?("twitter")
          student_page[:twitter] = a.attribute("href").value
        elsif (a.attribute("href").value).include?("linkedin")
          student_page[:linkedin] = a.attribute("href").value
        elsif (a.attribute("href").value).include?("github")  
          student_page[:github] = a.attribute("href").value
        else 
          student_page[:blog] = a.attribute("href").value
        end
      
      end
    student_page[:profile_quote] = profile.css(".profile-quote").text
    student_page[:bio] = profile.css(".description-holder p").text
    
    student_page
  end

end



