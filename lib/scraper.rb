require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = doc.css(".student-card")
    name = doc.css(".student-name").text
    location = doc.css(".student-location").text
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
