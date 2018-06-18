require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
      html = File.read("fixtures/student-site/index.html")
      student_scraper = Nokogiri::HTML(html)

      students = []

      students = {:name => student_scraper.css(".student-name").css("h4").text,
      :location => student_scraper.css(".student-location").text,
      :profile_url => student_scraper.css(".fixtures/student-site/index.html").text}
  end

  def self.scrape_profile_page(profile_url)

  end

end
