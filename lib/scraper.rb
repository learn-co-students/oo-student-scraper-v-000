require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      html = File.read("fixtures/student-site/index.html")
      student_scraper = Nokogiri::HTML(html)

      student = []

      student << students = {:name => student_scraper.css(".student-name").first.css("h4").text,
      :location => student_scraper.css(".student-location").first.text,
      :profile_url => student_scraper.css(".fixtures/student-site/index.html").first.text}
  end

  def self.scrape_profile_page(profile_url)

  end

end
