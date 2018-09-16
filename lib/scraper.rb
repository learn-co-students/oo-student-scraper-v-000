require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_card = doc.css("student-card")
    student_card.each do |card|
      student = Student.new
      student.name = student_card.css("student-name")
      student.location = student_card.css("student-location")
      student.profile_url = student_card.css("a")
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

