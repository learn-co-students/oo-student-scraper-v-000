require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_index = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students = []
    students_index.css(".student-card").each do |student|
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      student_attributes = {:name => student_name, :location => student_location, :profile_url => profile_url}
      students << student_attributes
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
