require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    test = doc.css("head link")
    binding.pry
    #name = post.css("card-text-container")
    #test_field = post.css("table")

  end

  def self.scrape_profile_page(profile_url)

  end

end

#test = Scraper.new
#test.scrape_index_page("http://46.101.233.210:30005/fixtures/student-site/")
#Scraper.scrape_index_page("http://46.101.233.210:30005/fixtures/student-site/")
Scraper.scrape_index_page("http://www.freerepublic.com")
