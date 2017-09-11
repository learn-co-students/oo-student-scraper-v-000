require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)

    students = []

    index_page.css("div.student-card").each do |student|
      new_student = {}
      new_student[:name] = student.css("div.card-text-container h4.student-name").text
      new_student[:location] = student.css("div.card-text-container p.student-location").text
      new_student[:profile_url] = student.css("a").attribute("href").value
      students << new_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
