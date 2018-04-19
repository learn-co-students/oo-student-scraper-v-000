require  'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraper_doc   = doc.css(".student-card a")

  #  binding.pry
       scraper_doc.each do |student|

         name = student.css(".student-name").text
         location = student.css(".student-location").text
          profile_url = student.attr("href")
          puts "name                     "  + name
          puts  "location                "  + location
          puts  profile_url

#
    end
#
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

  end

end

Scraper.scrape_index_page("fixtures/student-site/index.html")
