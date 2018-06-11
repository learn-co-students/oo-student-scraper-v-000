require 'open-uri'
require 'nokogiri'
require 'rubygems'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|

        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_url = student.attr('href')
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # html = open(profile_url)
    # profile_page = Nokogiri::HTML(html)
    #
    # student = {}
    #
    # links = profile_page.css("social-icon-container").each do ||

  end

end
