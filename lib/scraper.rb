require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = Array.new

    html = open(index_url)
    students = Nokogiri::HTML(html)

    students.css(".student-card").each do |s|
      student_name = s.css("h4.student-name").text
      student_location = s.css("p.student-location").text
      profile_url = "./fixtures/student-site/#{s.css("a").attr("href").text}"

      scraped_students << {name: student_name, location: student_location, profile_url: profile_url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
