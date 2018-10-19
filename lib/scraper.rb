require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end


#names doc.css("h4").text
#location doc.css("p").text
