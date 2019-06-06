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
      
    profile_page.css("div.vitals-text-container").find do |path|
      quote = path.css("div.profile-quote").text
      scraped_student[:profile_quote] = quote
    end 
     
    profile_page.css("div.details-container").find do |bio|
      bio.css("div.bio-block.details-block").find do |holder|
        student_bio = holder.css("div.description-holder p").text
        scraped_student[:bio] = student_bio  
      end
    end 
    scraped_student
  end

  
end

