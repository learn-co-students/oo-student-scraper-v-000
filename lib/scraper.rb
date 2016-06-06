require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # doc = Nokogiri::HTML(open(index_url))
    # doc = Nokogiri::HTML(open("http://127.0.0.1:4000/"))
    binding.pry
    #doc.css("h4").text == name of student
    #doc.css("p").text == location
    #doc.css("h4").text
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

