require 'open-uri'
require 'pry'

class Scraper
  def initialize
    @index = {name: "", location: "", profile_url: ""}
    @profiles = {}
  end

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    #name
    binding.pry
    #name
    doc.css(".student-name")
    
    #location
    doc.css(".student-location")
    
    #profile_url
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

