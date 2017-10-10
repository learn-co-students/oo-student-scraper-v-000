require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)

    students = Nokogiri::HTML(html)
    student_index_array = []

    students.css("div.student-card").each do |student|
      student_index_array << {name: student.css(" a div.card-text-container h4").text, location: student.css(" a div.card-text-container p").text, profile_url: student.css("a").attribute("href").value}
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(index_url)

    student_hash = Nokogiri::HTML(html)
    student_index_array = {}

  end

end
