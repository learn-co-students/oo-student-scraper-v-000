require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
  
    doc.css(".student-card").each do |student_card|
      student_hash = {}
      student_hash[:name] = student_card.css("h4").text
      student_hash[:location] = student_card.css("p").text
      student_hash[:profile_url] = index_url + student_card.css("a").attribute("href").value
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}

    doc.css(".social-icon-container a").each do |icon|
      link = icon.attribute("href").value
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else
       student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css("p").text
    student_hash
  end

end

