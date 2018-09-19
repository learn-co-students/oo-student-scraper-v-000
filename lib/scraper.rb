require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css(".student-card").each do |s|
      student_name        = s.css(".student-name").text
      student_location    = s.css(".student-location").text
      student_profile_url = s.css("a").first["href"]
      students << {:name => student_name, :location => student_location, :profile_url => student_profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    social = profile.css(".social-icon-container").children.css("a").map { |h| h.attribute('href').value}
    student = {}
    social.each do |l|
      if l.include?("linkedin")
        student[:linkedin] = l
      elsif l.include?("github")
        student[:github] = l
      elsif l.include?("twitter")
        student[:twitter] = l
      else
        student[:blog] = l
      end
    end 
    student[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")
    student
  end
end
