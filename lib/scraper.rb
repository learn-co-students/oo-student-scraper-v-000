require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

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

    html.css("div.social-icon-container a").each do |student| 
      if student.attribute("href").text.include?("linkedin")
        scraped_student[:linkedin] = student.attribute("href").text
      elsif student.attribute("href").text.include?("twitter")
        scraped_student[:twitter] = student.attribute("href").text
      elsif student.attribute("href").text.include?("github")
        scraped_student[:github] = student.attribute("href").text
      elsif student.css("img").attribute("src").text.include?("rss")
        scraped_student[:blog] = student.attribute("href").text
      end
    end
    scraped_student[:profile_quote] = html.css(".profile-quote").text
    scraped_student[:bio] = html.css(".description-holder p").text
    
    scraped_student
  end
end

