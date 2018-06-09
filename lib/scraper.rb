require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each {|card|
      card.css(".student-card").each { |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = student.css("a").attr("href").text
        students << {:name => name, :location => location, :profile_url => profile_url}
      }
    }
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
