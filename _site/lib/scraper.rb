require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").map do |student|
      {
        :name => student.css("student-name").text,
        :location => student.css("student-location").text,
        :profile_url => student.css("a").text
      }
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
