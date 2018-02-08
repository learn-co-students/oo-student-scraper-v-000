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

    doc.css(".roster-cards-container .student-card").each do |student-card|
      student = Student.new
      student.name = student-card.css("h4").text
      student.city = student-card.css("p").text
      student.url = student-card.css("a")[0]["href"]
    end
  end

  def self.scrape_profile_page(profile_url)

  end

end

#@@students = []
#@@students = doc.css(".roster-cards-container .student-card")
#Onestudent = doc.css(".roster-cards-container .student-card").first.css("h4").text
#Onelocation = doc.css(".roster-cards-container .student-card").first.css("p").text
#Onestudenturl = doc.css(".roster-cards-container .student-card").first.css("a")[0]["href"]
