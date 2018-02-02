require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
  	# Open document
  	doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))

  	# name = doc.css(".student-card").css(".student-name")[0].text
  	# location = doc.css(".student-card").css(".student-location")[0].text
  	# profile_url = doc.css(".student-card").css("a")[0]['href']

  	students = [];

  	doc.css(".student-card").each do |card|
  		student = Hash.new
  		student[:name] = card.css(".student-name").text
  		student[:location] = card.css(".student-location").text
  		student[:profile_url] = card.css("a")[0]['href']
  		students << student
  	end

  	students
  end

  def self.scrape_profile_page(profile_url)
  	# Open document
  	doc = Nokogiri::HTML(open(profile_url))

  	#main doc.css(".social-icon-container a").css("img").attribute("src").value
  	#twitter  == "../assets/img/twitter-icon.png"
  	#linkedin value == "../assets/img/linkedin-icon.png"
  	#github value == "../assets/img/github-icon.png"
  	#blog value == "../assets/img/rss-icon.png"

  	scraped_profile = Hash.new

  	doc.css(".social-icon-container a").each do |social|
  		if social.css("img").attribute("src").value == "../assets/img/twitter-icon.png"
  			scraped_profile[:twitter] = social.attribute("href").value
  		elsif social.css("img").attribute("src").value == "../assets/img/linkedin-icon.png"
  			scraped_profile[:linkedin] = social.attribute("href").value
  		elsif social.css("img").attribute("src").value == "../assets/img/github-icon.png"
  			scraped_profile[:github] = social.attribute("href").value
  		elsif social.css("img").attribute("src").value == "../assets/img/rss-icon.png"
  			scraped_profile[:blog] = social.attribute("href").value
  		end
  	end

  	#profile doc.css(".profile-quote").text
  	#bio doc.css(".description-holder").css("p").text
  	scraped_profile[:profile_quote] = doc.css(".profile-quote").text
  	scraped_profile[:bio] = doc.css(".description-holder").css("p").text

  	scraped_profile
  end

end

