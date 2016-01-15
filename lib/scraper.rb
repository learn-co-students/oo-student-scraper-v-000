require 'open-uri'
require 'pry'
#require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
  	index_page = Nokogiri::HTML(open(index_url))
  	student_info = index_page.css("div.student-card")
  	student_array =[]
  	student_info.each do |student|
  		student_hash = {}
  		student_hash[:name] = student.css("h4.student-name").text
  		student_hash[:location] = student.css("p.student-location").text
  		student_hash[:profile_url] = "http://students.learn.co/" + student.css("a")[0]["href"]
  		student_array << student_hash
  	end
  	student_array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

