require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
	student_list = []
	html = open(index_url)
	doc = Nokogiri::HTML(html)
	doc.css("div.roster-cards-container").each do |element|
		element.css(".student-card a").each do |student|
			link = "http://127.0.0.1:4000/#{student.attr('href')}"
			name = student.css('.student-name').text
			location = student.css('.student-location').text
			student_list << {name: name, location: location, profile_url: link}
		end
	end
	student_list
  end

  def self.scrape_profile_page(profile_url)
	student = Hash.new
    	html = open(profile_url)
	doc = Nokogiri::HTML(html)

	student[:bio] = doc.css(".description-holder p").text
	student[:profile_quote] = doc.css(".profile-quote").text	

	doc.css('.social-icon-container a').each do |link|
		if link['href'].include?('linkedin')
			student[:linkedin] = link['href']
		elsif link['href'].include?('twitter')
			student[:twitter] = link['href']
		elsif link['href'].include?('github')
			student[:github] = link['href']
		else
			student[:blog] = link['href']
		end
	end 
	student
  end

end

