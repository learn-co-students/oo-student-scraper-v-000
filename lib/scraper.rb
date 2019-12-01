require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    array = doc.css(".roster-cards-container")
    hash = Hash[array.collect { |key, value| [name, name.css(".student-name")] }
  end

  def self.scrape_profile_page(profile_url)

  end

end
