require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
   index_page = NOKOGIRI::HTML(open(index_url))
   students_idex_page = index_page.css(".roaster-cards-container")
   students_idex_page.each do |student|
    binding.pry

  end

  def self.scrape_profile_page(profile_url)
    
  end

end

