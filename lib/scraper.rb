require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    ary = []
    page = Nokogiri::HTML(open(index_url))
    student = page.css(".student-card")
      student.each do |i|
        hash = {}
        hash[:name] = i.css(".student-name").text
        hash[:location] = i.css(".student-location").text
        hash[:profile_url] = i.css("a").attribute("href").value
        ary << hash
      end
      ary
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    hash = {}
    page.css(".social-icon-container a").each do |i|
      if i.attribute("href").value.include?("twitter")
        hash[:twitter] = i.attribute("href").value
      elsif i.attribute("href").value.include?("linkedin")
        hash[:linkedin] = i.attribute("href").value
      elsif i.attribute("href").value.include?("github")
        hash[:github] = i.attribute("href").value
      else
        hash[:blog] = i.attribute("href").value
      end
    end
    hash[:profile_quote] = page.css(".profile-quote").text
    hash[:bio] = page.css(".bio-content .description-holder p").text
    hash
  end

end
