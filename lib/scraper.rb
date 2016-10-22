require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :index_url, :profile_url

  def self.scrape_index_page(index_url)
    #responsible for scraping the index page that lists all of the students. This gets a list of all the profiles
    doc = Nokogiri::HTML(open(index_url))    
    Pry.start(binding)
  end



  def self.scrape_profile_page(profile_url)
    #this scrapes the individual profiles
    
  end

end

