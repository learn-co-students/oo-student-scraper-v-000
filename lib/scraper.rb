require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index_page = Nokogiri::HTML(open(index_url))
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card").each do |student|
        student_profile_link = "./fixtures/student-site/"
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        students << {:name => student_name, :location => student_location, :profile_url => student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_page.css("")
    profile
  end

end
