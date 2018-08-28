require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css("student-card").each do |student|
    student = Student.new
    students.name = student.css("h4").text
    students.location = student.css("p").text
    students.profile_url = student.attr("href")
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

