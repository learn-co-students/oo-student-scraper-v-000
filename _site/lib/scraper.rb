require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    #returns a array of hashes in which each hash 
    #represents a single student
    doc = Nokogiri::HTML(open(index_url))

    array = []

   # name = doc.css(".card-text-container h4.student-name").first.text
   # location = doc.css("p.student-location").first.text 
   # profile_url = doc.css("div.student-card a").attribute("href").value
   
    #div.roster-cards-container 
    doc.css("div.student-card").map do |profile|
    
    hash = {
    student: doc.css(".card-text-container h4.student-name").first.text,
    location: doc.css("p.student-location").first.text,
    profile_url: doc.css("div.student-card a").attribute("href").value,
    }
  binding.pry
    array << hash
  end
  puts array
  array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

