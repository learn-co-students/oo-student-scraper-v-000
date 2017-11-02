require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # doc = Nokogiri::HTML(open("http://159.203.91.59:30000/fixtures/student-site/"))
      index_url = Nokogiri::HTML(open(index_url))
      students = []
    # doc.css.(".roster-cards-container")
    binding.pry

  end

  def self.scrape_profile_page(profile_url)

  end

end
