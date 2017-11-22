require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each {|person|
      students << {
        :name => person.css(".student-name").text,
        :location => person.css(".student-location").text,
        :profile_url => person.css("a").attribute("href").value
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
