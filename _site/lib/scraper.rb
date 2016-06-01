require 'open-uri'
require 'pry'

class Scraper

  # :name
  # :location
  # :profile_url

  def self.scrape_index_page(index_url)
    student_index = Nokogiri::HTML(open(index_url))

  end

  def self.scrape_profile_page(profile_url)

  end

end
