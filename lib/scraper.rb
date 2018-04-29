require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url
  # <h4 class="student-name">Ryan Johnson</h4>
  # doc.css(".card-text-container").first.css("h4")
  def self.scrape_index_page(index_url)
    hash = Hash.new  
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

