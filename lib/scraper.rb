require 'open-uri'
require 'pry'

class Scraper

 def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url)) #Nokogiri the url
    students = [] #create an empty array for the students
    
    index_page.css("div.roster-cards-container").each do |s_card| #for each student card
      
      s_card.css(".student-card a").each do |student| #for each aspect of a student card
        
        student_name = student.css('.student-name').text#get the student's name
        student_profile_link = "#{student.attr('href')}" #get the student's profile link
        student_location = student.css('.student-location').text #get the student's location
        
        students << {name: student_name, location: student_location, profile_url: student_profile_link} #add the student's information to the students array
      end #end the each-do for s_card
    end #end the each do for the index_page
    
    students #return the students array
  end #end the scrape_idex method
  
  
  def self.scrape_profile_page(profile_url)
    profile_page= Nokogiri::HTML(open(profile_url)) #nokogiri the student's profile
    student={} #set up a student hash
    
    #student's bio
    if profile_page.css('div.bio-content.content holder div.description-holder p') !=nil
    	student[:bio] = profile_page.css('div.bio-content.content-holder div.description-holder p').text
    end #if the student has a bio, get it
    
    #student's quote
    if profile_page.css('.profile-quote')
    	student[:profile_quote] = profile_page.css('.profile-quote').text
    end #if the student has a quote, get it
    
    #because the github, linkedin, and twitter are all contrained in the "social-icon-container."
    #	each of the links will be collected if they exist
    links=profile_page.css(".social-icon-container").children.css("a").collect { |s_el| s_el.attribute('href').value}
        links.each do |link|
        
      #binding.pry
      
      if link.include?("github") #if github is included on the page
      	student[:github] = link
      
      elsif link.include?("linkedin") #if linkedin is included on the page
        student[:linkedin] = link
          
      elsif link.include?("twitter") # if twitter is included on the page
        student[:twitter] = link
      else
        student[:blog] = link	# set up the blog
        
		end #end the links if/else
        end # end the each do links
	
	
	
	
	student
	end #end the scrape_profile page merthod
	
end
 # end the Scraper class
#linkedin
      #github
      #blog
      #profile quote '.profile-quote'
      #bio '.bio-content content holder div.description-holder'
