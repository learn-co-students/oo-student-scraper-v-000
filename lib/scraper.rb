require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = File.read("./fixtures/student-site/index.html")
    learn_students = Nokogiri::HTML(doc)

    students = {}

    learn_students.css('student-card').div
  end

  def self.scrape_profile_page(profile_url)

  end

end
