require 'open-uri'
require 'pry'
require 'nokogiri'

# require_relative './fixtures/student-site/index.html'

class Scraper

  def self.scrape_index_page(index_url)
    binding.pry
    index_url = File.open("./fixtures/student-site/index.html"){ |f| Nokogiri::HTML(f) }



    student = []
    puts index_url.css(".student-location").text

  end

  def self.scrape_profile_page(profile_url)

  end

end
