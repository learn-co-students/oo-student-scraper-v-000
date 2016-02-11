require 'open-uri'
require 'nokogiri'
require 'pry'
require 'jekyll'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    binding.pry

    #:name =
    #:location =
    #:profile_url = 


  end

  def self.scrape_profile_page(profile_url)
    
  end

end

