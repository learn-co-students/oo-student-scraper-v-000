require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css("div .student-card")
      puts doc

  end

  def self.scrape_profile_page(profile_url)

  end

end
