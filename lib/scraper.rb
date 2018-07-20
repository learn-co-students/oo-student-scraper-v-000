require 'open-uri'
require 'pry'

#index page: 
#name: student.css("h4.student-name").text
#location: student.css("p.student-location").text
#profile_url: student.css("a").attribute("href").value

#profile page: 
#list of children - doc.css("div.social-icon-container").children.css("a")
#twitter: 
#linkedin: 
#github: 
#blog: 
#profile_quote: doc.css("div.profile-quote").text
#bio: doc.css("div.description-holder p").text

class Scraper

  def self.scrape_index_page(index_url) #this one creates an array of hashes 
  	doc = Nokogiri::HTML(open(index_url)) 
  	students = []
  	doc.css("div.roster-cards-container").each do |card| 
  		card.css("div.student-card").each do |student|
	  		student_name = student.css("h4.student-name").text 
	  		student_location = student.css("div.card-text-container p").text 
	  		student_url = student.css("a").attribute("href").value
	  		
	  		students << {:name => student_name, :location => student_location, :profile_url => student_url}
	  	end
  	end
  	students 
  end

  def self.scrape_profile_page(profile_url) #this one creates a hash 
  	doc = Nokogiri::HTML(open(profile_url)) 
  	student = {} 
  	student[:bio] = doc.css("div.description-holder p").text
  	student[:profile_quote] = doc.css("div.profile-quote").text 
  	links = doc.css("div.social-icon-container").children.css("a").collect { |child| child.attribute("href").value } 
  	links.each do |link| 
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
    student
  end

end



