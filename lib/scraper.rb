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
