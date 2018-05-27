require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    
    profiles = page.css(".student-card")
    
    binding.pry 
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

