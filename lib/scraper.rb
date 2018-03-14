require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    doc.css("div .student-card").collect do |e|
      new_hash = {}
      new_hash[:name] = e.css(".student-name").text
      new_hash[:location] = e.css(".student-location").text
      new_hash[:profile_url] = e.css("a").attribute("href").value
      scraped_students << new_hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    new_hash = {}
    info_array = doc.css(".vitals-container .social-icon-container a").collect do |e|
      e.attribute("href").value
    end
    info_array.each do |soc|
      if soc.include?("twitter")
        new_hash[:twitter] = soc
      elsif soc.include?("linkedin")
        new_hash[:linkedin] = soc
      elsif soc.include?("github")
        new_hash[:github] = soc
      else soc.include?("blog")
        new_hash[:blog] = soc
      end
    end
    new_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    new_hash[:bio] = doc.css(".description-holder p").text
    new_hash
  end

end
