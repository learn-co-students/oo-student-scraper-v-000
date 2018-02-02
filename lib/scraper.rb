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
    
  end

end

