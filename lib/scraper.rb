require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
     doc.css(".roster-cards-container").each do |card| 
      card.css("a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_url = student.attr("href")
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
     end
   students
 end
  

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
     student_profile = []
  end

end

