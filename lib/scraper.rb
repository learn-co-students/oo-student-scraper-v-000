require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(index_url)
    students = doc.css(".roster-cards-container")
    scraped_students = []
    
    students.map do |student_list|
      student_list.map do |student|
      student_hash = {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css(".view-profile-div").text}
    end
       scraped_students << student_hash
  end
    scraped_students
    
    end

  def self.scrape_profile_page(profile_url)
    
  end

end

