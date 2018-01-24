require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").collect do |student|
      student_hash = {}
        student_hash[:name] = student.css("h4.student-name").text
        student_hash[:location] = student.css("p.student-location").text
        student_hash[:profile_url] = student.css("a").attr("href").value
      students << student_hash
    end
    students 
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    attributes_hash = {}
      attributes_hash[:bio] = doc.css("div p").text
      attributes_hash[:profile_quote] = doc.css("div.profile-quote").text
      doc.css("div.social-icon-container a").each do |icon|
        link = icon.attr("href")
        if link.include?("linkedin") 
          attributes_hash[:linkedin] = link
        elsif link.include?("twitter")
          attributes_hash[:twitter] = link
        elsif link.include?("github")
          attributes_hash[:github] = link
        else 
          attributes_hash[:blog] = link
        end
      end
      attributes_hash
  end

end

