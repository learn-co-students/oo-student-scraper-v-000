require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("http://46.101.242.134:3202/fixtures/student-site/index.html"))
    scraped_students = []
    # binding.pry
    doc.css("div.roster-cards-container").each do |all_cards|
      all_cards.css(".student-card").each do |student|
        student_url = "http://46.101.242.134:3202/#{student.attr("href")}"
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text

        scraped_students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    #scraped_students.map do |student|
    #  puts student[:profile_url]


    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
#index_url = "http://46.101.242.134:3202/fixtures/student-site/"


#Scraper.scrape_index_page(index_url)
