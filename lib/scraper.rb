require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
   
   scraped_students = []
   Scraper.scrape_index_page(index_url)
   { :name, :location, :profile_url}
   
   #3. Return value of this method should be an array of hashes in which each hash represents a single student. 
   
   #4. The keys of the individual student hashes should be :name, :location and :profile_url.
    
  end


  
  def self.scrape_profile_page(profile_url)
   #Return value to be a hash where k/v pairs describe an #individual student. Note how students don't have twitter #etc.
   #To Scrape: twitter url, linkedin url, github url, blog url, profile quote, and bio
   
   
    
  end


end

