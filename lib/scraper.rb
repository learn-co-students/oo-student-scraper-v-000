require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))
    binding.pry
    student_info = {}
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

