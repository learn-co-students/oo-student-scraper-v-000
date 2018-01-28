require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  

  def self.scrape_index_page(index_url)
    student_profiles = Nokogiri::HTML(open(index_url))

    students = [] #return an array of hashes

    student_profiles.css("div.roster-cards-container").each do |card|
    	card.css(".student-card a").each do |student|
    	students << {
    		:name => student.css(".student-name").text,
    		:location => student.css(".student-location").text,
    		:profile_url => student.attribute("href").value
    		}
    	end
    end
    students  
  end

  def self.scrape_profile_page(profile_url)
  	student_profile = Nokogiri::HTML(open(profile_url))

  	student = {}

  	profile_links = student_profile.css(".social-icon-container").children.css("a").collect do |link| 
  		link.attribute("href").value
  	end

  	profile_links.each do |link|
  		if link.include?("twitter")
  			student[:twitter] = link
  		elsif link.include?("linkedin")
  			student[:linkedin] = link
  		elsif link.include?("github")
  			student[:github] = link
  		else 
  			student[:blog] = link
  		end
  	end

  	student[:profile_quote] = student_profile.css("div.profile-quote").text ? student_profile.css("div.profile-quote").text : nil
  	student[:bio] = student_profile.css("div.description-holder p").text ? student_profile.css("div.description-holder p").text : nil
  	#could also drill down using "div.bio-content.content-holder div.description-holder p"

  	student
  	#binding.pry
  end

end

