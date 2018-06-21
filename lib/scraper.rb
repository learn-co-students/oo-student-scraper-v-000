require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = student.css("a").attr("href").text
        students << {:name => name, :location => location, :profile_url => profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
