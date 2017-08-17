require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_data = doc.css(".student-card")
    student_data.collect do |s|
        student = {}
        student[:name] = s.css(".student-name").text
        student[:location] = s.css(".student-location").text
        student[:profile_url] = s.css("a").attribute("href").value
        student
    end 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css(".social-icon-container a")
    quote = doc.css(".profile-quote")
    bio = doc.css(".bio-content p")
    student_attributes = {}
    social.each do |s|
        if s.attribute("href").value.include?("twitter")
            student_attributes[:twitter] = s.attribute("href").value
        elsif s.attribute("href").value.include?("linkedin")
            student_attributes[:linkedin] = s.attribute("href").value
        elsif s.attribute("href").value.include?("github")
            student_attributes[:github] = s.attribute("href").value
        else
            student_attributes[:blog] = s.attribute("href").value
        end
    end
    student_attributes[:profile_quote] = quote.text
    student_attributes[:bio] = bio.text
    student_attributes
  end

end

