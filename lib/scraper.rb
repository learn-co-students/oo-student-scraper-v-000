require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(open('./fixtures/student-site/index.html'))
    student_index_array = []
    doc.css(".student-card").each do |student|
    name = student.css("h4.student-name")
    location = student.css("p.student-location")
    profile_url = student.css("href")
    student_index_array << {name: name, location: location, profile_url: profile_url}
  end
    student_index_array
  end
  

  def self.scrape_profile_page(profile_url)
    
  end

end

