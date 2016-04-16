require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css(".roster-cards-container").each do |student_card|
      student_card.css(".student-card").each do |student|
        student_info = {
          name: student.css(".student-name").text,
          location: student.css(".student-location").text,
          profile_url: "http://127.0.0.1:4000/#{student.attr("href")}"
          }
        students << student_info
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end

