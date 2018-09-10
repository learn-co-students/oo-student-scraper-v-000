require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    hash_ary = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
  end

  def self.scrape_profile_page(profile_url)

  end

end
