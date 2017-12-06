require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    section = doc.css(".student-card")
    section.each do |student|
      scraped_students << {name: student.css("h4").text, location: student.css(".student-location").text, profile_url: student.css("a").attribute("href").value}
    end
    scraped_students
  end

  # {twitter: student.css("a").attribute("href").value}

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    links = doc.css(".social-icon-container").css("a")
    profile = Hash.new
    links.each do |link|
      case
      when link.attribute("href").value.include?("twitter.com")
        profile[:twitter] = link.attribute("href").value
      when link.attribute("href").value.include?("github.com")
        profile[:github] = link.attribute("href").value
      when link.attribute("href").value.include?("youtube.com")
        profile[:youtube] = link.attribute("href").value
      when link.attribute("href").value.include?("linkedin.com")
        profile[:linkedin] = link.attribute("href").value
      else
        profile[:blog] = link.attribute("href").value
      end
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder").css("p").text
    profile
  end

end
