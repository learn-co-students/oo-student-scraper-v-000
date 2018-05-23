require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :location, :name, :profile_url

  def self.scrape_index_page(index_url)
    index_url = "./fixtures/student-site/index.html"
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        # binding.pry
      student_profile_link = "#{student.attr('href')}"
      student_location = student.css(".student-location").text
      student_name = student.css(".student-name").text

      # {:name => student_name, :location => student_location, :profile_url => student_profile_link}
      end
    end
    scraped_students <<  {name: student_name, location: student_location, profile_url: student_profile_link}

  end

  def self.scrape_profile_page(profile_url)

  end

end
