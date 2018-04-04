require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("index_url"))
    student = [{}]

    student[:name] =
    student[:location] =
    student[:profile_url] = 

    end


  end

  def self.scrape_profile_page(profile_url)

  end

end
