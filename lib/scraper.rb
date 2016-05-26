require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    #returns a array of hashes in which each hash 
    #represents a single student
    doc = Nokogiri::HTML(open('http://students.learn.co/'))

    array = []

   # name = doc.css(".card-text-container h4.student-name").first.text
   # location = doc.css("p.student-location").first.text 
   # profile_url = doc.css("div.student-card a").attribute("href").value
   

    doc.css("div.student-card").each do |profile|
    
    hash = {
    student: doc.css(".card-text-container h4.student-name").first.text,
    location: doc.css("p.student-location").first.text,
    profile_url: doc.css("div.student-card a").attribute("href").value,
    }

    array << hash
  end
  array

  end

  def self.scrape_profile_page(profile_url)
    
  end

end

