require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    
    students = Nokogiri::HTML(open(index_url))
    scraped_students = []
   
    students.css("div.roster-cards-container").each do |card|
    	card.css(".student-card a").each do |student|

    		student_name = student.css(".student-name").text
     		student_location = student.css(".student-location").text
    		student_profile_url = "#{student.attr('href')}"
    		scraped_students << {name: student_name, location: student_location, profile_url: student_profile_url}
    	end
    	
	end
  scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    scraped_profile = {}

   social_links = profile.css("div.social-icon-container a").map { |link| link["href"]}

   social_links.each do |link|
   		if link.include?("twitter")
   			scraped_profile[:twitter] = link
   		elsif link.include?("linkedin")
   			scraped_profile[:linkedin] = link
   		elsif link.include?("github")
   			scraped_profile[:github] = link
   		else	
   			scraped_profile[:blog] = link
   		end
   	end

   	scraped_profile[:profile_quote] = profile.css("div.profile-quote").text
   	scraped_profile[:bio] = profile.css("p").text

   	scraped_profile
  end

end

