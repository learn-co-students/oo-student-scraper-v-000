require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        students << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "#{student.attr('href')}"
        }
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    

  end

end
