require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |student_info|
      student_index_hash = {}
      student_index_hash[:name] = student_info.css("h4").text
      student_index_hash[:location] = student_info.css("p").text
      student_index_hash[:profile_url] = student_info.css("a").attribute("href").value
      student_index_hash
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container").css("a").attribute("href").value
    doc.css(".social-icon-container").css("a")[1].attribute("href").value
    doc.css(".social-icon-container").css("a")[2].attribute("href").value
    doc.css(".social-icon-container").css("a")[3].attribute("href").value
    doc.css(".vitals-text-container").css(".profile-quote").text
    doc.css(".description-holder").css("p").text

end

