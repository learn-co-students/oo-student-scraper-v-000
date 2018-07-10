require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    students_doc = doc.css(".roster-cards-container")
    student_list = students_doc.css(".student-card").map{|e| e}
    student_list.each {|student| students << {:name => student.css("h4").text, :location => student.css("p").text, :profile_url => student.css("a").attr("href").value}}
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end
end
