require 'open-uri'
require 'nokogiri'
require 'pry'
# name = student.css("h4.student-name").text
# location = student.css("p.student-location").text
# profile_url = student.css("a.")
class Scraper

  def self.scrape_index_page(index_url)
    learn = Nokogiri::HTML(index_url)
    students = []

    learn.css("div.roster-cards-container").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text
      }
      binding.pry
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
