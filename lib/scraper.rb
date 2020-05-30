require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_array = []
    index_page.css(".roster-cards-container").each do |student|
    student.css(".student-card a").each do |info|
    student_name = info.css(".student-name").text
    student_location = info.css(".student-location").text
    student_pro_url = "#{info.attr('href')}"
        
    student_array << {:name => student_name, :location => student_location, :profile_url => student_pro_url}
    end 
  end
    student_array
end

  def self.scrape_profile_page(profile_url)
    scrape_page = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    profile_page = scrape_page.css(".social-icon-container a").collect do |icon| 
      icon.attribute("href").value
    end
    
    profile_page.each do |link| 
      if link.include?("twitter")
        profile_hash[:twitter] = link
          
      elsif link.include?("linkedin")
        profile_hash[:linkedin] = link 
          
      elsif link.include?("github")
        profile_hash[:github] = link
          
      elsif link.include?(".com")
        profile_hash[:blog] = link
            
      elsif link.include?("profile-quote")
        profile_hash[:profile_quote] = link 
          
      elsif link.include?("bio")
        profile_hash[:bio] = link
        end
      end 
      
    profile_hash[:profile_quote] = scrape_page.css(".profile-quote").text 
    profile_hash[:bio] = scrape_page.css("div.description-holder p").text
    profile_hash
  end
end

