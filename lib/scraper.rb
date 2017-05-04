require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    html = open("fixtures/student-site/index.html")
	  doc = Nokogiri::HTML(html)  
	  scraped_students = doc.css(".student-card")
    nodeset = doc.css('a[href]')
	  scraped_students.map do |student|
       student_hash = {}
       student_hash[:name]= student.css(".student-name").text
       student_hash[:location] = student.css(".student-location").text 
       student_hash[:profile_url] = student.css("a").attr("href").value
       student_hash
    end 
  end
  def self.scrape_profile_page(profile_url)
     student_hash = {}
  end
end
#Scraper.new.scrape_index_page("fixtures/student-site/index.html")
#student.url = student.first.css(?????).text
      #http://ruby.bastardsbook.com/chapters/html-parsing/
      #https://www.sitepoint.com/nokogiri-fundamentals-extract-html-web/
      #http://stackoverflow.com/questions/7107642/getting-attributes-value-in-nokogiri-to-extract-link-urls