require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a"). each do |student|
        profile = "./fixtures/student-site/#{student.attr("href")}"
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        students << {profile_url: profile, name: name, location: location}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
  end
end
