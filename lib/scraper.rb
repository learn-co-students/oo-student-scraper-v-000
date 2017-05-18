require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #return array of hashes
    students = {}
  end

  def self.scrape_profile_page(profile_url)

  end

  binding.pry

end
