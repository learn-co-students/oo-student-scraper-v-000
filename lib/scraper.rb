require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	html = open(index_url)
  	doc = Nokogiri::HTML(html)
  	students = []
  		doc.css("div.student-card").each do | card |
  		student_cards = {}
  		student_cards[:name] = card.css(".student-name").text
  		student_cards[:location] = card.css(".student-location").text
  		student_cards[:profile_url] = card.css("a").attribute("href").value
  		students << student_cards
  	end
    students

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    	student_profile = {}
    		doc.css("div.social-icon-container a").each do |icons|
    			if icons["href"].include? 'twitter'
    			  	student_profile[:twitter] = icons["href"]
    			elsif icons["href"].include? 'linkedin'
    			  	student_profile[:linkedin] = icons["href"]
    			elsif icons["href"].include? 'github'
    			  	student_profile[:github] = icons["href"]
    			else icons["href"].include? 'blog'
    			  	student_profile[:blog] = icons["href"]
    			 end
    			student_profile[:profile_quote] = doc.css(".profile-quote").text
    			student_profile[:bio] = doc.css(".description-holder p").text
    		end
    		student_profile
    	
  end





end

