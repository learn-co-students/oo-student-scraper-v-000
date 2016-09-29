require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    scraped_students = []
    student_hash = {}

    html = open(index_url)

    doc = Nokogiri::HTML(html)

    doc.css(".student-card").each do |student|
      student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.children[1].attribute("href").value
      }
      scraped_students << student_hash
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
