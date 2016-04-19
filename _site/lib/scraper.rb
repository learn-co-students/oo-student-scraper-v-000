require 'open-uri'
require 'pry'

class Scraper

  attr_reader :name, :location, :profile_url

  ## responsible for scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    
  end

  ## responsible for scraping an individual student's profile page_
  ## to get further information about that student
  def self.scrape_profile_page(profile_url)
    
  end

end

