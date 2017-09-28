require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []

    index.css(".student-card").each do |student|
      students << {
        :name => student.css("a .card-text-container .student-name").text,
        :location => student.css("a .card-text-container .student-location").text,
        :profile_url => student.css("a").attribute("href").text
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)

  end
end

# Scraper.scrape_index_page("./fixtures/student-site/index.html")
