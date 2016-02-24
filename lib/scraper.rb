require 'open-uri'
require 'pry'
require 'Nokogiri'

class Scraper

	attr_accessor :name, :location, :profile_url, :linkedin, :github, :blog, :profile_quote, :bio

	def self.scrape_index_page(profile_url)
	  	scraped_students = []
	    doc = Nokogiri::HTML(open(profile_url))

	    	doc.css(".student-card").each do |student|
	    		student_name = student.css('.student-name').text
	    		student_location = student.css('.student-location').text
	    		student_url = profile_url + student.css('a').attribute("href").value
	    		scraped_students << {name: student_name, location: student_location, profile_url: student_url}
	    	end
	  return scraped_students
	end

  def self.scrape_profile_page(profile_url)

    profile = Nokogiri::HTML(open(profile_url))
    scraped_student = Hash.new
	socials = profile.css(".social-icon-container a").map {|link| link.attribute("href").value }

	socials.each do |social|
    	if social.include?("twitter")
    		scraped_student[:twitter] = social
    	elsif social.include?("linkedin")
    		scraped_student[:linkedin] = social
    	elsif social.include?("github")
    		scraped_student[:github] = social
    	else 
    		scraped_student[:blog] = social
    	end
	end

	scraped_student[:profile_quote] = profile.css('div.profile-quote').text
	scraped_student[:bio] = profile.css(".description-holder p").text

	scraped_student
end
end

