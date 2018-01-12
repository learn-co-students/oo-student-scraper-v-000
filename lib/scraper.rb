require 'open-uri'
require 'pry'

class Scraper
  # responsible for scraping the index page that lists all of the students
  def self.scrape_index_page(url)
    doc = Nokogiri::HTML(open(url))
    roster = doc.css("div.student-card")
    roster.map do |student|
      {
      name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: student.css("a").first["href"]
      }
    end
  end

  # responsible for scraping an individual student's profile page
  def self.scrape_profile_page(url)

  end

end
