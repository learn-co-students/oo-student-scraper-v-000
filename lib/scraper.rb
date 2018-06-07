require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    arr = []
    doc = Nokogiri::HTML(open(index_url))
    doc = doc.css(".student-card")
    doc.collect do |card| 
      arr << {name: card.css(".student-name").text, location: card.css(".student-location").text, profile_url: card.css("a").attribute("href").value}
    end
    arr
  end

  def self.scrape_profile_page(profile_url)
    bio = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |link|
      social = link.attributes["href"].value.split(/[\/ .]/)
        if social.include?("twitter")
          bio[:twitter] = link.attributes["href"].value
        elsif social.include?("linkedin")
          bio[:linkedin] = link.attributes["href"].value
        elsif social.include?("github")
          bio[:github] = link.attributes["href"].value
        else
          bio[:blog] = link.attributes["href"].value
        end
      end
      bio[:profile_quote] = doc.css(".profile-quote").text
      bio[:bio] = doc.css(".description-holder p").text
      bio
    end
end
