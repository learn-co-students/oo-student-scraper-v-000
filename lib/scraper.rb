require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card(".")
      binding.pry # for example
      
    end
end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

