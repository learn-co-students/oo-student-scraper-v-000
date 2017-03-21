require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".student-card")
    students.each do |student|
      puts student.css(".student-name").text
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
