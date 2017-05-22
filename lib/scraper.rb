require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = open(index_url)
    doc = Nokogiri::HTML(index_page)
    doc.css(".roster-cards-container")
    name : doc.css(".roster-cards-container").first.css("h4").text
    location : doc.css(".roster-cards-container").first.css("p").text
    profile_url :
    binding.pry
  end

  def self.scrape_profile_page(profile_url)
    profile_url
  end

end
