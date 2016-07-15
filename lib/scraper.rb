require 'open-uri'
require 'pry'

class Scraper


  def self.scrape_index_page(index_url)
    student_cards = Nokogiri::HTML(open(index_url)).css(".student-card")
    students = []
    student_cards.map do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile = student.css("a")[0]["href"]
      students << {name: name, location: location, profile_url: profile}
    end
    students.flatten
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
  end

end

