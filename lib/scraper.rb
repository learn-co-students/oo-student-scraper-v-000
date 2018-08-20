require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    results = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("body div div div.roster-cards-container").each do |container|
      student = {
        :name => doc.css("div.card-text-container h4").text
        :location => doc.css("div.card-text-container p").text
        :profile_url =>
      }
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
