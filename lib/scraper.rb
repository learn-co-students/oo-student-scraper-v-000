require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    profiles = Nokogiri::HTML(html)
    students = []
    profiles.css("div.roster-cards-container").each do |container|
      container.css(".student_card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_url = "#{student.attr('href')}"
        binding.pry
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
      binding.pry
    end
    binding.pry
      students
  end

  def self.scrape_profile_page(profile_url)

  end

end
