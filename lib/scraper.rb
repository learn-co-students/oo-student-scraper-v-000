require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
#describe "#scrape_index_page" do
 #   it "is a class method that scrapes the student index page and a returns an array of hashes in which each hash represents one student" do
 #     index_url = "./fixtures/student-site/index.html"
 #     scraped_students = Scraper.scrape_index_page(index_url)
 #     expect(scraped_students).to be_a(Array)
 #     expect(scraped_students.first).to have_key(:location)
 #     expect(scraped_students.first).to have_key(:name)
 #     expect(scraped_students).to include(student_index_array[0], student_index_array[1], student_index_array[2])
  #  end
  def self.scrape_index_page(index_url)
    html = open("fixtures/student-site/index.html")
	  doc = Nokogiri::HTML(html)  
	  scraped_students = doc.css(".student-card")
	  scraped_students.each do |student|
      student = Student.new(name, location, profile_url) 
      student.name = student.first.css(".student-name").text
      student.location = student.first.css(".student-location").text 
      binding.pry
       #                   end 
      #student.url = student.first.css(?????).text
      #http://ruby.bastardsbook.com/chapters/html-parsing/
      #https://www.sitepoint.com/nokogiri-fundamentals-extract-html-web/
  end
  #def first 
   # @first = scraped_students[:location] scraped_students[:name]
  #end 
  def self.scrape_profile_page(profile_url)
    
  end
end
#Scraper.new.scrape_index_page("fixtures/student-site/index.html")
