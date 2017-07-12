require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css("div.student-card").each do |card|
      students << {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    profile = {}

    links = doc.css("div.social-icon-container a").collect { |site| site.attribute("href").value }
    links.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("facebook")
        profile[:facebook] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      else
        profile[:blog] = link
      end
    end

    profile[:profile_quote] = doc.css("div.profile-quote").text
    profile[:bio] = doc.css("div.description-holder p").text
    profile
  end
end
