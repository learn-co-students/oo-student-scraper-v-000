require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    array = doc.css(".roster-cards-container")
    # hash = {}
    # hash = Hash[array.collect { |key, value| [name, name.css(".student-name")] }
    # hash = Hash[*array.flatten]
    # hash = Hash[array.map {|key, value| [name, name.css(".student-name")]}]
    # a3 = [ ['apple', 1], ['banana', 2], [['orange','seedless'], 3] ]
    # h3 = Hash[*a3.flatten]
    binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
