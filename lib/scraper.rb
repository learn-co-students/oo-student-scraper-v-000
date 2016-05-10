require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card a").each do |card|
      student = {name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: "http://127.0.0.1:4000/#{card["href"]}"}
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    students = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.social-icon-container a").each do |link|
      if link["href"].include?("twitter")
        students[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        students[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        students[:github] = link["href"]
      else
        students[:blog] = link["href"]
      end
    end
    students[:profile_quote] = doc.css("div.profile-quote").text
    students[:bio] = doc.css("div.description-holder p").text
    students
  end

end
