require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    binding.pry
    html = File.read(index_url)
    index_page = Nokogiri::HTML(html)

    students = {}

    index_page.css('.roster-cards-container .student-card').each_with_index do |student, index|
      name = student.css('a .card-text-container h4.student-name').text
      location = student.css('a .card-text-container p.student-location').text
      profile_url = student.css('a').attribute('src').value
      students[index] = {
        name: name,
        location: location,
        profile_url: profile_url
      }

      students
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
