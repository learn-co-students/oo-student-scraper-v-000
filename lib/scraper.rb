require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :location, :name

  def self.scrape_index_page(index_url)
    index_url = "./fixtures/student-site/index.html"
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    binding.pry
    # doc.css("div.roster-cards-container").each do |card|
      # students = doc.css("div.student-card div.card-text-container")
      # name = doc.css("div h4.student-name").text
      # location = doc.css("div p.student-location").text
      # profile_url =
  end

  def self.scrape_profile_page(profile_url)

  end

end
