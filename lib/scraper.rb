require 'open-uri'
require 'pry'

class Scraper # does not store information- just scrapes and sends to STUDENT CLASS for storage

  def self.scrape_index_page(index_url) # scrape the INDEX page that lists all students
    # return value should be an array of hashes - each hash is a single student
    # keys ---- :name, :location, :profile_url

  end

  def self.scrape_profile_page(profile_url) # scrape INDIVIDUAL student's profile
    # use NOKOGIRI and OPEN-URI to access page
    # return value should be a hash - key/value pairs describing individual student
    # EDGECASE - some students do not have socialmedia linked up
    # :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  end

end
