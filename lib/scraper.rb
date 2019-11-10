require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    binding.pry

    #doc.css(".student-name").text.strip

  end



  def self.scrape_profile_page(profile_url)

  end

end
