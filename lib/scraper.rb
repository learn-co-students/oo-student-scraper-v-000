require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    binding.pry
    doc = Nokogiri::HTML(open(fixtures/student-site/index.html))
  end

  def self.scrape_profile_page(profile_url)

  end

end
