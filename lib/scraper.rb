require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = {}
    doc.css(".student-card").first
    #locations = doc.css("p.student-location").first.text
    binding.pry
  end
  #names = doc.css("h4.student-name").text
  def self.scrape_profile_page(profile_url)

  end

end
