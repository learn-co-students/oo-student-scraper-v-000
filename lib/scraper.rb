require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    page = Nokogiri::HTML(index_url)
    students = []

    page.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
