require 'open-uri'
require 'pry'

#reqyure nokogiri?
class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index = Nokogiri::HTML(html)

  end

  def self.scrape_profile_page(profile_url)
    
  end

end

