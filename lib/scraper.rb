require 'open-uri'
require 'pry'

class Scraper

#scrapes main student page for name, student location and profile url 
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".student-card").each do |card|
    	card_data = {}
    	  card_data[:name] = card.css(".student-name").text
    	  card_data[:location] = card.css(".student-location").text
    	  card_data[:profile_url] = card.css("a")[0]["href"]
    	students << card_data
    end
    students	  
  end


#scrapes student profil url for social media links, bio, profile quote
  def self.scrape_profile_page(profile_url)
  	student = {}
  	profile_page = Nokogiri::HTML(open(profile_url))
  	
    student[:bio] = profile_page.css("div.description-holder p").text 
  	student [:profile_quote] = profile_page.css("div.profile-quote").text 
  
  	links = profile_page.css(".social-icon-container").children.css("a").map { |social| social.attribute('href').value}
  	
  	links.each do |link|
  		if link.include?("linkedin")
  			student[:linkedin] = link
  		elsif link.include?("twitter")
  			student[:twitter] = link
  		elsif link.include?("github")
  		    student[:github] = link
  		else 
  		    student[:blog] = link  
  		end   
     end 		      
  	 student   
  end
    
    
end

