require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    hashes = []
    doc.css(".student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile = student.css("a").first["href"]
      hashes << {:profile_url => profile, :name => name, :location => location}
    end
    hashes
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}

  profile = doc.css(".social-icon-container").children.css("a").map { |social| social.attribute('href').value}
  bio = doc.css(".description-holder p").text
  quote = doc.css(".profile-quote").text
  links = doc.css(".social-icon-container a").map do |link|
    link.attribute('href').value
  end
  links.each do |link|
    if link.include?("twitter")
      hash[:twitter] = link
    elsif link.include?("linkedin")
      hash[:linkedin] = link
    elsif link.include?("github")
      hash[:github] = link
    else
      hash[:blog] = link
    end
  end
      hash[:profile_quote] = quote
      hash[:bio] = bio

      hash
  end

end
