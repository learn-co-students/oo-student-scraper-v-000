require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_index_array = []
    doc.css(".student-card").each do |student|
      stu_hash = {}
      stu_hash[:name] = student.css(".student-name").text
      stu_hash[:location] = student.css(".student-location").text
      stu_hash[:profile_url] = "http://127.0.0.1:4000/" + student.css('a')[0]["href"]
    student_index_array << stu_hash
    #binding.pry
    end
    return student_index_array
  end

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
    scraped_student ={}
    links = doc.css(".social-icon-container").children.css("a").collect { |a| a.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        scraped_student[:linkedin] = link
      elsif link.include?("github")
        scraped_student[:github] = link
      elsif link.include?("twitter")
        scraped_student[:twitter] = link
      else
        scraped_student[:blog] = link
      end
    end
     
    if doc.css(".profile-quote")
      scraped_student[:profile_quote] = doc.css(".profile-quote").text 
    end
    
    if doc.css("div.bio-content.content-holder div.description-holder p")
      scraped_student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text 
    end
    
    scraped_student
    
    end
    
  end


