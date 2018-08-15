require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    binding.pry
    # doc.css(".student-card") => provides the individual student objects
    # doc.css(".student-card").first.css(".student-name") => provides the student's name
    # doc.css(".student-card").first.css(".student-location") => provides the student's location
    # doc.css(".student-card").first.css("a").map {|link| link['href']}[0]
  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.scrape_index_page("http://165.227.31.208:53117/fixtures/student-site/")
