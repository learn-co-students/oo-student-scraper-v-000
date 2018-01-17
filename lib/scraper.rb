require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    roster = doc.css(".student-card")

    roster.each do |person|
      student = {}
      student[:name] = person.css(".student-name").text
      student[:location] = person.css(".student-location").text
      student[:profile_url] = person.css("a").attribute("href").value
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
