require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)

    students = []
  
    roster.css("div.student-card").each do |student|
      student_name = roster.css("h4.student-name").text
      students[student_name.to_sym] = {
        name: student_name,
        location: student.css("div.card-text-container p.student-location").text,
        profile_url: student.css("div.student-card a").attribute("href").value
      }
     students
    end# of do
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

