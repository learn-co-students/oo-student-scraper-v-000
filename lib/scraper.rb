require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    names = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    students.each.tap do |name|
      names << name.css("h4").text
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
