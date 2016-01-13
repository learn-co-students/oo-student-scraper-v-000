require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    Nokogiri::HTML(open(index_url)).css(".student-card").collect {|c|
        { 
        name: c.css("h4").text,
        location: c.css(".student-location").text,
        profile_url: "http://students.learn.co/#{c.css("a").attribute("href").value}"
        }}
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url)).css(".profile > div:not(:empty)")
    social_details = profile.css(".social-icon-container a").collect{|s|
      s.attribute("href").value}.flatten
    social_hash = 
      {
        twitter: social_details.detect{|d| d.include?("twitter")},
        linkedin: social_details.detect{|d| d.include?("linkedin")},
        github: social_details.detect{|d| d.include?("github")},
        blog: social_details.last,
        profile_quote: profile.css(".profile_quote").text,
        bio: profile.css(".description-holder p").text
      }
  end
end
