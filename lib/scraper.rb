
require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |roster|
      roster.css(".student-card").each do |student|
#iterate thru the roster cards to get the student: name location and url
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      binding.pry
      #profile_link = (how to select the href?)
      #students << {name: name, location: location ,profile_url: profile_link}
    end
  end
  students
end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

  end

end
