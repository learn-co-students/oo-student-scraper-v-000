require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    # doc.css(".student-card") => provides the individual student objects
    # doc.css(".student-card").first.css(".student-name").text => provides the student's name
    # doc.css(".student-card").first.css(".student-location").text => provides the student's location
    # doc.css(".student-card").first.css("a").map {|link| link['href']}[0]

    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").map {|link| link['href']}[0]
      students << student_hash
      #binding.pry
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    # doc.css(".social-icon-container a").map {|link| link['href']}[0] => Twitter Profile link, string
    # doc.css(".social-icon-container a").map {|link| link['href']}[1] => Linkedin Profile link, string
    # doc.css(".social-icon-container a").map {|link| link['href']}[2] => Github Profile link, string
    # doc.css(".social-icon-container a").map {|link| link['href']}[3] => Youtube Profile link, string

    binding.pry
  end

end

Scraper.scrape_profile_page("http://165.227.16.205:49641/fixtures/student-site/students/ryan-johnson.html")
