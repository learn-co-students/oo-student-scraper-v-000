require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = Nokogiri::HTML(open("http://students.learn.co/"))

    profiles_hash = {}

    profiles..css(".roster-cards-container")

  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.new
