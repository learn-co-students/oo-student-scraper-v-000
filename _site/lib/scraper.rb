require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #responsible for scraping the index page that lists all of the students
    doc :nokogiri::HTML(open("#{index_url}"))
    binding.pry
  end

  def self.scrape_profile_page(profile_url)
    #responsible for scraping an individual student's profile page to get further information about that student

  end

end
