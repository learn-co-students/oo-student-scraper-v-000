require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students_array = []
    students = doc.css(".student-card")
    students.each do |student|
      student = {
        :student_name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students_array << student
    end
    students_array
    binding.pry
end

  def self.scrape_profile_page(profile_url)

  end
end
