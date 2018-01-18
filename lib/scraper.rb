require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    roster = doc.css(".student-card")

    roster.each do |person|
      student = {}
      student[:name] = person.css(".student-name").text
      student[:location] = person.css(".student-location").text
      student[:profile_url] = person.css("a").attribute("href").value
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container a")
    profile = {}
    links.each do |link|
      address = link.attribute("href").value
      profile[:twitter] = address if address.include?("twitter")
      profile[:linkedin] = address if address.include?("linkedin")
      profile[:github] = address if address.include?("github")
      profile[:blog] =  address if link.css("img").attribute("src").value.include?("rss-icon")
    end
    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".bio-content p").text
    profile
  end

end
