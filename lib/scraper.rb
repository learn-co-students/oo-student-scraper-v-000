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
  	scraped_students = []
    html = open("fixtures/student-site/index.html")
	doc = Nokogiri::HTML(html)
	#doc.search("h1.profile-name h2.profile-location").text
	scraped_students << doc.css(".profile-name .profile-location").text
	scraped_students 
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

