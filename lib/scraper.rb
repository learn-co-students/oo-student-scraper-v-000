require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  @@all = []
  @student_hash = {}

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    # names = doc.css(".student-name")
    # locations = doc.css(".student-location")
    # profile_url = doc.css(".student-card").css("a").attribute("href").value

    #name
    allstudents = doc.css(".student-card")
    allstudents.each{ |item| 
      student_hash = {}
      student_hash[:name] = item.css(".student-name").text
      student_hash[:location] = item.css(".student-location").text
      student_hash[:profile_url] = item.css("a").attribute("href").value
      @@all << student_hash
    }
    
    binding.pry
    
    #profile_url
    
    #location
    # locations = doc.css(".student-location").text
    # locations.each{|location|
    #   @student_hash[:location] = location
    # }
    # #profile_url
    # binding.pry
  end
  #binding.pry

  def self.scrape_profile_page(profile_url)
    
  end

end

