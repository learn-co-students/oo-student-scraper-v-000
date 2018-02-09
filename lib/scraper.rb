require 'open-uri'
require 'pry'

class Scraper
  def initialize
    @student_hash = {}
  
  end

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    #name
    names = doc.css(".student-name")
    names.each{ |name| 
      @student_hash[:name] = name
    }
    
    #location
    locations = doc.css(".student-location")
    locations.each{|location|
      @student_hash[:location] = location
    }
    binding.pry
    #profile_url
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

