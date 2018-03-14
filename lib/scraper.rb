require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    binding.pry
    #name : doc.css(".student-name").text
    #location: doc.css(".student-location")
    #profile_url: doc.css(".student-card").children[1].attributes["href"].value



  end

  def self.scrape_profile_page(profile_url)

  end

end
