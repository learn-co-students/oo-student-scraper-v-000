require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

@practice_html = "./fixtures/student-site/index.html" #Local website file
@practice_url = "./fixtures/student-site/students/ryan-johnson.html"


  def self.scrape_index_page(index_url = @practice_html) #Optional variable for local testing
	index = Nokogiri::HTML(open(index_url)) #Stores index page into a variable
	students = []
	index.css("div.student-card").each do |student|
	
	#----- Obtain student variables -----
	name = student.css("a h4.student-name").text
	location = student.css("a p.student-location").text
	profile_url = "./fixtures/student-site/" + student.css("a").attribute("href").value
	#----- Store hash of variables in an array -----
	students << {name: name, location: location, profile_url: profile_url}

    end # end of each loop
    students
  end



  def self.scrape_profile_page(profile_url = @practice_url)
  	student = {}
   	page = Nokogiri::HTML(open(profile_url))
  	sites = page.css(".social-icon-container a").map { |a| a['href'] } #collects all the values for each attribute (https string)
  	sites.each do |i|
  		student[:twitter]= i if i.include?("twitter")
  		student[:linkedin]= i if i.include?("linkedin")
  		student[:github]= i  if i.include?("github")
  		student[:blog]= i unless (i.include?"github") || (i.include?"linkedin") || (i.include?"twitter")
  	end # end of each method
  	student[:profile_quote]= page.css(".profile-quote").text if page.css(".profile-quote").text #sets the student profile quite if exists
  	student[:bio]= page.css("p").text if page.css("p").text #sets student bio if exists

  	student
  end
end

=begin 
				INDEX PAGE
Individual student = index.css("div.student-card")
Student name = index.css("div.student-card a h4.student-name").text
	
Student location = index.css("div.student-card a p.student-location").text

Profile URL = index.css("div.student-card a").attribute("href").value
				
				PROFILE PAGE
profile quote = page.css(".profile-quote").text
social pages =  page.css(".social-icon-container a")
bio = pages.css("p").text

	
=end
Scraper.scrape_index_page