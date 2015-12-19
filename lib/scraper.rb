require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  # students: learn.css("div.student-card")
  # name: student.css("div.card-text-container h4.student-name").text
  # location: student.css("div.card-text-container p.student-location").text
  # profile_url: student.css("a").attribute("href").value

  def self.scrape_index_page(index_url)
    learn = Nokogiri::HTML(open(index_url))

    students = []

    learn.css("div.student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("div.card-text-container h4.student-name").text
      student_hash[:location] = student.css("div.card-text-container p.student-location").text
      student_hash[:profile_url] = "#{index_url}/#{student.css("a").attribute("href").value}"
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# Scraper.scrape_index_page("http://students.learn.co")

