require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
 
 attr_accessor :name, :location, :profile_url 
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
     a = []
     doc.css(".student-card").each { |x|
       
     h = {
      :name  =>   x.css(".student-name").text,
      :location => x.css(".student-location").text,
      :profile_url => "http://students.learn.co/"+x.css("a")[0]["href"]} 
      a << h 

      }
     
      a 
  end

  def self.scrape_profile_page(profile_url)
    
    doc = Nokogiri::HTML(open(profile_url))
      
       {
        :twitter => doc.css(".social-icon-container a")[0]["href"],
        :linkedin => doc.css(".social-icon-container a")[1]["href"],
        :github => doc.css(".social-icon-container a")[2]["href"],
        :blog => doc.css(".social-icon-container a")[3]["href"],
        :profile_quote => doc.css(".profile-quote").text ,
        :bio => doc.css(".description-holder p").text 
      }
  end

end

