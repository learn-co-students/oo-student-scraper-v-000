require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    
    index_page.css(".student-card a").each do |card|
      student_name = card.css(".student-name").text
      student_location = card.css(".student-location").text
      student_profile_url = "#{card.attr("href")}"
      
      students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    
    links = profile_page.css(".social-icon-container a").collect{|l| l.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".description-holder p").text
    student
  end
  
end

