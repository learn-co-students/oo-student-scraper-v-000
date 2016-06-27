require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
  	doc = Nokogiri::HTML(open(index_url))
  	students = []

    doc.css(".roster-cards-container .student-card a").collect do |student|
	  name = student.css(".card-text-container h4").text
	  location = student.css(".card-text-container p").text
	  profile_url = "http://127.0.0.1:4000/#{student['href']}"
	  students << {name: name, location: location, profile_url: profile_url}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
  	doc = Nokogiri::HTML(open(profile_url))
  	scraped_student = {}
  	doc.css(".social-icon-container a").each do |profile|
      if profile.attr("href").include?("twitter")
        scraped_student[:twitter] = profile.attr("href")
      elsif profile.attr("href").include?("linkedin")
        scraped_student[:linkedin] = profile.attr("href")
      elsif profile.attr("href").include?("github")
  	    scraped_student[:github] = profile.attr("href")
  	  elsif profile.attr("href")
  	    scraped_student[:blog] = profile.attr("href")
  	  end	
  	  scraped_student[:profile_quote] = doc.css(".profile-quote").text
  	  scraped_student[:bio] = doc.css(".description-holder p").text
  	 
  	end
  	scraped_student
  end
end




