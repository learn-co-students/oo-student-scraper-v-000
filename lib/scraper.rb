require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    scraped_students = []

    html = Nokogiri::HTML(open(index_url)) 
    html.css(".student-card").collect do |student|
      student_hash = { 
        :name => student.css(".student-name").text, 
        :location =>student.css("p.student-location").text,
        :profile_url => "http://students.learn.co/" + student.css("a").attribute("href").text 
      }
      scraped_students << student_hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}

    html = Nokogiri::HTML(open(profile_url))
    html.css("div.social-icon-container a").each do |links|
      link = links.attribute("href").text
      
      if link.include?("linkedin")
        scraped_student[:linkedin] = link 
      elsif link.include?("twitter")
        scraped_student[:twitter] = link 
      elsif link.include?("github")
        scraped_student[:github] = link
      elsif links.css("img").attribute("src").text.include?("rss")
        scraped_student[:blog] = link
      end 
    end
    scraped_student[:profile_quote] = html.css(".profile-quote").text
    scraped_student[:bio] = html.css(".description-holder p").text

    scraped_student
  end
end
