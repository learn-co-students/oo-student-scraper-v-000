require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    site = Nokogiri::HTML(open(index_url))
    students = []
    
    site.css(".roster-cards-container").each do |roster_card|
      roster_card.css(".student-card a").each do |student|
        
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_url = "./fixtures/student-site/#{student.attribute("href").value}"
        
        students << {name: student_name, location: student_location, profile_url: student_profile_url} 
   
      end
    end
    
    students
  end

  
  def self.scrape_profile_page(profile_url)
    site = Nokogiri::HTML(open(profile_url))
    students = {}

    site.css(".vitals-container .social-icon-container a").each do |vitals|
      social = vitals.attribute("href").value
      if social.include?("twitter")
        students[:twitter] = social
      elsif social.include?("linkedin")
        students[:linkedin] = social
      elsif social.include?("github")
        students[:github] = social
      else
        students[:blog] = social
      end

      students[:profile_quote] = site.css(".vitals-text-container .profile-quote").text
      students[:bio] = site.css(".description-holder p").text
    end
    
    students
  end

end

