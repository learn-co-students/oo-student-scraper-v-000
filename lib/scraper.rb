require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

@html = File.read('../fixtures/student-site/index.html') #Local website file

  def self.scrape_index_page( index_url = @html) #Optional variable for local testing
	students = []
	index = Nokogiri::HTML(index_url) #Stores index page into a variable
	
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


  def self.scrape_profile_page(profile_url)
    
  end

end

=begin 
Individual student = index.css("div.student-card")
Student name = index.css("div.student-card a h4.student-name").text
	
Student location = index.css("div.student-card a p.student-location").text

Profile URL = index.css("div.student-card a").attribute("href").value

	
=end

Scraper.scrape_index_page