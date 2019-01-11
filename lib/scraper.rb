require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text 
        student_location = student.css(".student-location").text
        student_website = student.attr("href")
      students << {name: student_name, location: student_location, profile_url: student_website}
      end
    end 
    students
  end
 


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
  
      profile_page.css("div.social-icon-container").children.css("a").each do |url|

        link = url.attr("href")
        binding.pry
        if link.include?("twitter")
          scraped_student[:twitter] = link
        elsif link.include?("github")
          scraped_student[:github] = link
        elsif link.include?("linkedin")
          scraped_student[:linkedin] = link
        else 
          scraped_student[:blog] = link
        end
      end
      
  end
end


