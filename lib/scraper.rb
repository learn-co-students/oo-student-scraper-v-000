require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))

    #other option 
    #html = File.open(index_url)
    #scraped_page = Nokogiri::HTML(html)

    result = []
    students = {} 

    binding.pry
  end

  #name = html.css(".student-card").first.css("h4").text
  #location = html.css(".student-card").first.css("p").text

  def self.scrape_profile_page(profile_url)
    
  end

end


Scraper.new.scrape_index_page("./fixtures/student-site/index.html")

