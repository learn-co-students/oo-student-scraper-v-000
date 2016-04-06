require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card a").each do |card|
      student_hash = Hash.new
      student_hash[:name] = card.css("h4").text
      student_hash[:location] = card.css("p").text
      student_hash[:profile_url] = "http://127.0.0.1:4000/#{card.attribute("href")}"
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container a").map {|link| link.attribute("href").value}
    links.each do |link|
      case
      when link.include?("twitter")
        student_hash[:twitter] = link
      when link.include?("linkedin")
        student_hash[:linkedin] = link
      when link.include?("github")
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = doc.css(".profile-quote").text if doc.css("profile.quote")
    student_hash[:bio] = doc.css(".bio-block .description-holder p").text if doc.css(".bio-block .description-holder p")

    student_hash
  end

end
