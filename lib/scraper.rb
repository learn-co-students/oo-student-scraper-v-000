require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    arr = []
    index.css(".student-card").each do |student|
      hash = {}
      hash[:profile_url] = student.css("a").attr('href').text
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      arr << hash
    end
    arr
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    #puts profile.css('//a[@href*="twitter"]').attr('href').text
    #puts profile.css('//a[@href*="linkedin"]').attr('href').text
    #puts profile.css('//a[@href*="github"]').attr('href').text
    #puts profile.css(".social-icon-container a").last.attr('href')
    #puts profile.css(".profile-quote").text
    #puts profile.css(".description-holder p").text

    #puts profile.css(".social-icon-container a").to_s.size

    hash = {}
    if profile.css(".social-icon-container a").to_s.include?("twitter")
      hash[:twitter] = profile.css('//a[@href*="twitter"]').attr('href').text
    end
    hash[:linkedin] = profile.css('//a[@href*="linkedin"]').attr('href').text
    hash[:github] = profile.css('//a[@href*="github"]').attr('href').text
    if profile.css(".social-icon-container a").to_s.include?("rss")
      hash[:blog] = profile.css(".social-icon-container a").last.attr('href')
    end
    hash[:profile_quote] = profile.css(".profile-quote").text
    hash[:bio] = profile.css(".description-holder p").text
    hash

  end

end
