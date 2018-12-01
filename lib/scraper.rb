require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_data = doc.css("div.roster-cards-container")
    student_data.each do |card|
    	student_hash = Hash.new
 		# card.css(".student-card a")
 		student_hash[:name] = card.css(".student-card a").css("div:nth-child(2)").css(".student-name").first.text
 		student_hash[:location] = card.css(".student-card a").css("div:nth-child(2)").css(".student-location").first.text
 		binding.pry
    end
    # student_hash = Hash.new 
    # students.each do |student|
    # 	student_hash[:name] = student
    # end
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
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