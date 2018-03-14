require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
	

  def self.scrape_index_page(index_url)
  	arr = []
  	doc = Nokogiri::HTML(open(index_url)) # css class: .student_card 

    student = doc.css(".student-card")

    student.each do |student| 
    	hash = {}
    	hash[:name] = student.css(".student-name").text #keys: name location profile_url
    	hash[:location] = student.css(".student-location").text
    	hash[:profile_url] = student.css("a")[0]['href']
    	arr << hash
    end
    arr
  end

  def self.scrape_profile_page(profile_url)
    
  	doc = Nokogiri::HTML(open(profile_url))

  	student = doc.css(".profile")
    	hash = {}
    	
    	count = 0
    	while count < student.css(".social-icon-container a").length
    		#binding.pry

	    	social = student.css(".social-icon-container a")[count]["href"]
	    	
		    	if social.include? "linkedin"
		    		hash[:linkedin] = student.css(".social-icon-container a")[count]["href"]
		    	elsif social.include? "twitter"
		    		hash[:twitter] = student.css(".social-icon-container a")[count]["href"]
		    	 #keys: :linkedin :github :blog :profile_quote :bio
		    	elsif social.include? "github"
		    		hash[:github] = student.css(".social-icon-container a")[count]["href"]
		    	else
		    		hash[:blog] = student.css(".social-icon-container a")[count]["href"]
		    	end
	    		count += 1
	    	
		end

    	hash[:profile_quote] = student.css(".profile-quote").text
    	hash[:bio] = student.css(".details-container p").text
    	
    hash
  end

end

