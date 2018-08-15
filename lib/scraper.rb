require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    binding.pry
    # roster = doc.css(".student-card")
  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.scrape_index_page("http://165.227.31.208:53117/fixtures/student-site/")
