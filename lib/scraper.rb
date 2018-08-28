require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    
    doc = Nokogiri::HTML(open(index_url))
    student_index_array ={}
    
    doc.css("student-card").collect do |student_info|
    student = Student.new
    student.name = student_info.css("h4").text
    student.location = student_info.css("p").text
    student.prolifle_url = student-info.attr("href")
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

