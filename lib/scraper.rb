require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student.rb'


class Scraper
  #
  # html = File.read("./fixtures/student-site/index.html")
  # doc = Nokogiri::HTML(html)

  def self.scrape_index_page(index_url)

    html = File.read(index_url)
    doc = Nokogiri::HTML(html)
    @@students = []

    doc.css(".roster-cards-container .student-card").each do |student_card|
      student_card_hash = {}
      student = Student.new(student_card_hash)
      student.name = student_card.css("h4").text
      student_card_hash[:name] = student.name
      student.location = student_card.css("p").text
      student_card_hash[:location] = student.location
      student.profile_url = student_card.css("a")[0]["href"]
      student_card_hash[:profile_url] = student.profile_url
      @@students << student_card_hash
    end
    @@students
  end

  def self.scrape_profile_page(profile_url)

  end

end

#@@students = []
#@@students = doc.css(".roster-cards-container .student-card")
#Onestudent = doc.css(".roster-cards-container .student-card").first.css("h4").text
#Onelocation = doc.css(".roster-cards-container .student-card").first.css("p").text
#Onestudenturl = doc.css(".roster-cards-container .student-card").first.css("a")[0]["href"]
