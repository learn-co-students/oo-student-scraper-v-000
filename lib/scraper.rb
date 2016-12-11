require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")

    scraped_students = []

    students.each do |student|
      scraped_students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "./fixtures/student-site/#{student.css("a").attribute("href").value}"
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css(".bio-content .description-holder p").text






  end

end
