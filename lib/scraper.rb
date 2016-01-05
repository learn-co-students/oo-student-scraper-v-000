require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
	def self.scrape_index_page(index_url)
		doc = Nokogiri::HTML(open(index_url))
		student_divs = doc.css(".student-card")

		students = student_divs.map {|student|
			student_hash = {}
			student_hash[:name] = student.css(".student-name").text
			student_hash[:location] = student.css(".student-location").text
			student_hash[:profile_url] = "#{index_url}/#{student.css("a")[0]["href"]}"		
			student_hash
		}
	end

	def self.scrape_profile_page(profile_url)
		doc = Nokogiri::HTML(open(profile_url))
    	links = doc.css(".social-icon-container")	
		student_info_hash = {}

		links.css("a").each {|link|
			student_info_hash[:twitter] = link["href"] if link["href"].include?("twitter")
			student_info_hash[:linkedin] = link["href"] if link["href"].include?("linkedin")
			student_info_hash[:github] = link["href"] if link["href"].include?("github")
			student_info_hash[:blog] = link["href"] if link.css("img").attr("src").text.include?("rss")
		}

		student_info_hash[:profile_quote] = doc.css(".profile-quote").text
		student_info_hash[:bio] = doc.css(".bio-block .description-holder p").text

		student_info_hash
	end
end

