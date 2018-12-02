require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = Array.new
    student_data = doc.css("div.roster-cards-container .student-card a")
    student_data.each do |card|
 		student_name = card.css("div:nth-child(2)").css(".student-name").first.text
 		location = card.css("div:nth-child(2)").css(".student-location").first.text
 		profile_url  = card.attribute("href").value
 		student_hash ={:name => student_name, :location => location, :profile_url => profile_url}
 		students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profiles = Hash.new
    binding.pry
  end

end

# doc.css("div.roster-cards-container").first.css("h4").text
# students = student_names.split /(?<=[a-z])(?=[A-Z])/

# card.css(".student-card a")

   	# student_names = card.css(".student-card a").css(".student-name").text
    # 	student_names.split /(?<=[a-z])(?=[A-Z])/
    # 		student_names each do |name|
    # 		student_hash[:name] = name


       # student_locations = doc.css("div.roster-cards-container").first.css("p").text

       		# students << student_hash[:name] = student_name
 		# students << student_hash[:location] = location 
 		# students << student_hash[:profile_url] = profile_url
 		# binding.pry

 		# 		student_name = card.css(".student-card a").css("div:nth-child(2)").css(".student-name").first.text
 		# location = card.css(".student-card a").css("div:nth-child(2)").css(".student-location").first.text
 		# profile_url  = card.css(".student-card a").attribute("href").value