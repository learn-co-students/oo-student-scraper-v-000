require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    get = Nokogiri::HTML(open(index_url))

    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
Scraper.new.scrape_index_page(http://159.203.117.55:3024/)
