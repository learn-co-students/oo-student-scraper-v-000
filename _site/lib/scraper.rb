require 'open-uri'
require 'pry'

class Scraper

  # :name
  # :location
  # :profile_url



  def self.scrape_index_page(index_url)
    scraped_students = []
    student_index = Nokogiri::HTML(open(index_url))
    student_index.css("div.roster-cards-container").each do |card|
      card.css("div.student-card").each do |student|
        student.css("")

  end

  def self.scrape_profile_page(profile_url)

  end

end
