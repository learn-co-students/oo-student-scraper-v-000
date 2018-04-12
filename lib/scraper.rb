  
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(index_url)
    students = doc.css(".student-card")
    scraped_students = []
    students.map do |student|
      student_hash = {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css("a")[0]["href"]}
       scraped_students << student_hash
     end
    scraped_students
    end

  def self.scrape_profile_page(profile_url)
    array = self.scrape_index_page(open("./fixtures/student-site/index.html"))
    profiles = array.map do |students|
      students[:profile_url]
    end
    profiles
  end

end

