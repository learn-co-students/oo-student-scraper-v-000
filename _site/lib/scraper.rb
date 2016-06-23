require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
		html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    container = doc.css("div.roster-cards-container")
		container.css("div.student-card").each do |within_student|
			student_link = "http://127.0.0.1:4000/" + within_student.css("a").attribute("href").value
			student_name = within_student.css("a div.card-text-container h4.student-name").text
			student_location = within_student.css("a div.card-text-container p.student-location").text
			students << {:name => student_name, :location => student_location, :profile_url => student_link}
		end
		students
	end 
	
	def self.scrape_profile_page(profile_url)
		html = open(profile_url)
		doc = Nokogiri::HTML(html)
		hash = {}
		doc.css("div.social-icon-container a").each do |x|
			y = x.attribute("href").value
			if y.include?("twitter")
				hash[:twitter] = y
			elsif y.include?("linkedin")
				hash[:linkedin] = y
			elsif y.include?("github")
				hash[:github] = y
			elsif x.css("img").attribute("src").value.include?("rss")
				hash[:blog] = y
			end			
		end
			
		hash[:profile_quote] = doc.css("div.profile-quote").text
		hash[:bio] = doc.css("div.description-holder p").text
		hash
	end

end

