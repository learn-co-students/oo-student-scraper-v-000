require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = File.read('fixtures/student-site/index.html')
    doc = Nokogiri::HTML(index_page)
    index_hash = []
    doc.css(".student-card a").each do |person|
      index_hash << {
        :name => person.css(".student-name").text,
        :location => person.css(".student-location").text,
        :profile_url => "#{person.attr('href')}"
      }
    end
    index_hash
  end

  def self.scrape_profile_page(profile_url)

  end

end
