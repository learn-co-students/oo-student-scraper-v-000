require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    scraped_students = []
    students.each do |student|
      hash = Hash.new
      hash[:name] = student.css(".student-name").text
      hash[:location] = student.css(".student-location").text
      hash[:profile_url] = student.css("a").attribute("href").value
      scraped_students << hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
