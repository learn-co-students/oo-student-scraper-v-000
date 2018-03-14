require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |profile|
      students << {
        name: profile.css(".student-name").text,
        location: profile.css(".student-location").text,
        profile_url: "http://students.learn.co/#{profile.css('a').attribute('href').value}"
      } 
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    links = []
    profile = {}
    doc = Nokogiri::HTML(open(profile_url)).css(".profile")

    doc.css(".social-icon-container a").each { |icon| links << icon.attribute('href').value }
    links.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end

    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text

    profile
  end
end