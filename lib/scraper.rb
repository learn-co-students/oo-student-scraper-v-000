require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_profile_url = "./fixtures/student-site/#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
      binding.pry
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
