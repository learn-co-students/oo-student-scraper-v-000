require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
    def self.scrape_index_page(index_url)
      	index_page = Nokogiri::HTML(open(index_url))
      	students = []
      	index_page.css("div.roster-cards-container").each do |card|
        	card.css(".student-card a").each do |student|
          		student_profile_link = "#{student.attr('href')}"
          		student_location = student.css('.student-location').text
          		student_name = student.css('.student-name').text
          		students << {name: student_name, location: student_location, profile_url: student_profile_link}
        	end
      	end
      	students
    end

  	def self.scrape_profile_page(profile_url)
      	profile_page = Nokogiri::HTML(open(profile_url))
		student_profile = []
		student_details_hash = {}

		profile_page.css(".social-icon-container a").each do |link|
			student_profile << link["href"]
		end

		student_profile.each do|link|
			if link.include?("twitter")
				student_details_hash[:twitter] = link
			elsif link.include?("linkedin")
				student_details_hash[:linkedin] = link
			elsif link.include?("github")
				student_details_hash[:github] = link
			else

				student_details_hash[:blog] = link
			end
		end
		student_details_hash[:profile_quote] = profile_page.css("div.profile-quote").text
      	student_details_hash[:bio] = profile_page.css(".description-holder").first.text.strip!
		student_details_hash
	end
end
