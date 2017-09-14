require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each do |profile|
      student = {}

      student[:name] = profile.css("h4" ".student-name").text
      student[:location] = profile.css("p" ".student-location").text
      student[:profile_url] = profile.css("a").attribute("href").value
      
      students << student
    end 
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile_data = Hash.new(nil)

    profile_data[:profile_quote] = doc.css(".profile-quote").text.strip
    profile_data[:bio] = doc.css(".description-holder").css("p").text

    doc.css(".social-icon-container a").each do |el|
      href = el.attribute("href").value

      if el.attribute("href").value.include?("twitter")
        profile_data[:twitter] = href
      elsif el.attribute("href").value.include?("linkedin")
          profile_data[:linkedin] = href
      elsif el.attribute("href").value.include?("github")
        profile_data[:github] = href
      elsif el.css("img").attribute("src").value.include?("rss")
        profile_data[:blog] = href
      end 
    end 
    profile_data
  end

end

#Scraper.scrape_profile_page('./fixtures/student-site/students/joe-burgess.html')