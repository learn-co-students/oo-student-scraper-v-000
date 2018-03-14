require 'open-uri'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
   index_page = Nokogiri::HTML(open(index_url))
   #per inspecting the info for the students is located in the 'a' under div.roster-cards-container
    student_info = index_page.css('div.roster-cards-container a')
    #iterate through the student info and get the name, location and profile url per student in a hash.
    student_info.map { |student|
      {
      	#name is grabbed from the student-name class
        name:student.css('.student-name').text,
        #loction is grabbed from the student-location class
        location:student.css('.student-location').text,
        #use .attr to get the link by grabing the info from the href attribute
        profile_url:student.attr('href')
      }
      }
  end


  def self.scrape_profile_page(profile_url)
  	# hash in which the key/value pairs describe an individual student.
  	student = {}
  	profile_page = Nokogiri::HTML(open(profile_url))
  	#the links are located in the social icon container class
  	#they are the children in this class
  	# we iterate through the children using the css 'a' and getting the lnks using the hrf attribute to each one
  	links = profile_page.css(".social-icon-container").children.css("a").map { |l| l.attribute('href').value}
  	#iterate through the links and check each one for the different types of profiles
  	links.each do |link|
  		#if the link includes the profile add the profile to the student
  		if link.include?("linkedin")
  			student[:linkedin] = link
  		elsif link.include?("github")
  			student[:github] = link
  		elsif link.include?("twitter")
  			student[:twitter] = link
  		else
  			student[:blog] = link
  		end
  	end
  	#obtain the student profile quote and bio if there is a profile quote and bio
  	#these are separate.
  		 student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    	 student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
		 student
  end

end
    
