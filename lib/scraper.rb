require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    # binding.pry
    scrape = Nokogiri::HTML(open(index_url))
    scraped_students = []
    # binding.pry
    scrape.css("div.student-card").each do |student|
      student = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      scraped_students << student
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
