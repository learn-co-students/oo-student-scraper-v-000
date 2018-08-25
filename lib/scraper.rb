require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    scraped_students = html.css(".roster-cards-container")
    students = []
      scraped_students.each do |student|
        student_name = student.css(".student-card a .card-text-container .student-name").text
        #binding.pry
        student_location = student.css(".student-card a .card-text-container .student-location").text[0]
        student_profile = student.css("")
      students << {key: value, key: value, key: value}
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
