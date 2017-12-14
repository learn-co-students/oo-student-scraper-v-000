require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    profiles = doc.css("div.roster-cards-container .student-card")
    profiles.each do |profile|
      scraped_students << {
        name: profile.css("a .card-text-container .student-name").text,
        location: profile.css("a .card-text-container .student-location").text,
        profile_url: profile.css("a")[0]["href"],
      }

    end

    scraped_students

  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |link|
      if link["href"].include? ("twitter")
         student[:twitter] = link["href"]
      elsif link["href"].include? ("linkedin")
        student[:linkedin] = link["href"]
      elsif link["href"].include? ("github")
        student[:github] = link["href"]
      else
        student[:blog] = link["href"]
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".bio-content.content-holder p").text
    student
  end



end
