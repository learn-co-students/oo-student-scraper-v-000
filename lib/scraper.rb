require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    binding.pry
    doc = Nokogiri::HTML(open(index_url))
    doc.css("h4.student-name")
  end

  def self.scrape_profile_page(profile_url)

  end

end
