require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

      #This is a class method that should take in an argument of the URL of the index page. 
    #It should use nokogiri and Open-URI to access that page. The return value of this method 
    #should be an array of hashes in which each hash represents a single student. 
    #http://127.0.0.1:4000/
    doc = Nokogiri::HTML(open("http://127.0.0.1:4000/"))

    students = {}

    #The keys of the individual student hashes should be :name, :location and :profile_url
    #:name = (".roster-cards-container.card-text-container h4.student-name").text
    #:location = .card-text-container p.student-location).text
    #profile_url = roster-cards-container.student-card).attribute("src").value
    name = doc.css(".roster-cards-container.student-card").first.css(".card-text-container h4.student-name").text

    binding.pry
    
   
  

  end

  def self.scrape_profile_page(profile_url)
    
  end

end


