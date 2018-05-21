require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :location, :name

  def self.scrape_index_page(index_url)
    index_url = "./fixtures/student-site/index.html"
    scraped_students = [{:location}

    ]

  end

  def self.scrape_profile_page(profile_url)

  end

end
