require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    
    doc = Nokogiri::HTML(open(index_url))
    student_index_array ={}
    
    doc.css("student-card").collect do |student|
    student = Student.new
    student_index_array[:name] = student.css("h4").text
    student_index_array[:location]= student.css("p").text
    student_index_array[:profile_url] = student.attr("href")
    end
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

