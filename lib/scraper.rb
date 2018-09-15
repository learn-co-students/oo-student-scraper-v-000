require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css(".roster-cards-container .student-card").each do |student|
      students << {:name => student.css(".card-text-container .student-name").text,
                   :location => student.css(".card-text-container .student-location").text,
                   :profile_url => student.children.css("a").attribute("href").value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
