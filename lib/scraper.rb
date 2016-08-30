require 'pry'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc
    binding.pry
  end
end
