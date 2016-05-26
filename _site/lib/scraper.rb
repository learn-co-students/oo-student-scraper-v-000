require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    #returns a array of hashes in which each hash 
    #represents a single student
    doc = Nokogiri::HTML(open('http://students.learn.co/'))

    #name = doc.css(".card-text-container h4.student-name").first.text
    #location doc.css("p.student-location").first.text 
    #profile_url
      puts doc.css("a").attr("href").value
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

