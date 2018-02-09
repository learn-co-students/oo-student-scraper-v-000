require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  @@all = []

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    names = doc.css(".student-name")
    locations = doc.css(".student-location")
    names.each{ |name| 
      student_hash = {}
      student_hash[:name] = name.text
      student_hash[:location] = location.text
      student_hash << @@all
    }
    
    #profile_url
    binding.pry
  end
  #binding.pry

  def self.scrape_profile_page(profile_url)
    
  end

end

