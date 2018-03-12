require 'open-uri'
require 'pry'
require 'nokogiri'

index_url = "fixtures/student-site/index.html"

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(index_url)
    scraped_students = []

    scraped_students = [
    :name => index.css(".student-name").text
    :location => index.css(".student-location").text
    :profile_url => index.css(".student-card").text
  ]
  end

  def self.scrape_profile_page(profile_url)

  end

end
