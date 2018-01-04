require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  doc=Nokogiri::HTML(open("fixtures/student-site/index.html"))
  student_hash[:name]=doc.css(".student-name").text
  student_hash[:location]=doc.css(".student-location").text
  student_hash[:profile_url]=doc.css(".student-card a").attribute( "href").value
  binding.pry


#  def self.scrape_index_page(index_url)
    #doc=Nokogiri::HTML(open(index_url))
    #student_hash={}
    #student_hash[:name]=doc.css(".student-name").text
    #student_hash[:location]=doc.css(".student-location").text
    #student_hash[:profile_url]=doc.css(".student-card a").attribute( "href").value
    #students_array<<student_hash

#  end

#  def self.scrape_profile_page(profile_url)

#  end

end
