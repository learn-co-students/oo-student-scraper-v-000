require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css('.roster-cards-container .student-card').each do |student|
      students << {
        name: student.css('a .card-text-container h4.student-name').text,
        location: student.css('a .card-text-container p.student-location').text,
        profile_url: "http://127.0.0.1:4000/#{student.css('a').attribute('href').value}"
      }
    end

    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
