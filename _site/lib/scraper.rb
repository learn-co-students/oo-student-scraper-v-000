require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      student = {
        :name => card.css("div h4.student-name").text,
        :location => card.css("div p.student-location").text,
        :profile_url => "http://159.203.117.55:3217/" << card.css("a").attribute("href").value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    doc = Nokogiri::HTML(open(profile_url))

    social_links = doc.css(".social-icon-container a").collect do |link|
      link.attribute("href").value
    end
    social_links.each do |link|
      case
      when link.include?("linkedin")
        profile[:linkedin] = link
      when link.include?("github")
        profile[:github] = link
      when link.include?("twitter")
        profile[:twitter] = link
      else
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".bio-content p").text
    profile
  end
end
