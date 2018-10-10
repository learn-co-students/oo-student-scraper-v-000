require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url = "./fixtures/student-site/index.html")

    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry



  end

  def self.scrape_profile_page(profile_url = "./fixtures/student-site/index.html")

  end

end
