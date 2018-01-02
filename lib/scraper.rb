require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index_array = []
    # index_page = Nokogiri::HTML(open(index_url))
    html = File.read("fixtures/student-site/index.html")
    doc = Nokogiri::HTML(html)

    doc.css("div.student-card").each_with_index do |student, index|
      name = student.css('.card-text-container .student-name').text
      location = student.css('.card-text-container .student-location').text
      profile_url = student.css('a').attribute('href').value

      student_index_array << {
        :name        => name,
        :location    => location,
        :profile_url => profile_url
      }
    end

    student_index_array
  end

  def self.scrape_profile_page(profile_url)

  end

end
