require 'open-uri'
require 'nokogiri'
require 'pry'
#require_relative '../fixtures/student-site/index.html'

class Scraper

  def self.scrape_index_page(index_url)
      index_url = File.read("fixtures/student-site/index.html")
      doc = Nokogiri::HTML(open(index_url))
      binding.pry
    #div .student-card
    # => h4 .student-name text
    # => p .student-location text
  end

  def self.scrape_profile_page(profile_url)

  end

end
