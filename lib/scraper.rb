require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	html = open(index_url)
    doc = Nokogiri::HTML(html)
   # puts doc
    data = doc.css(".student-card")
    students = []
   # binding.pry
    data.each do |div|
    	student_name = div.css(".student-name").text
    	student_location = div.css(".student-location").text
    	student_url = div.css("a").map {|link| link["href"]}.first
    	students << {:name => student_name, :location => student_location, :profile_url => student_url}
   # 	binding.pry
    end
  # binding.pry
    students
  end

  def self.scrape_profile_page(profile_url)
  	html = open(profile_url)
  	doc = Nokogiri::HTML(html)
  	hash = {}
  	links = doc.css("a").map {|link| link["href"]}
  	links.each do |link|
  		if link.include?("linkedin")
  			hash[:linkedin] = link
  		elsif link.include?("twitter")
  			hash[:twitter] = link 
  		elsif link.include?("github")
  			hash[:github] = link
  		else
  			hash[:blog] = link unless link.include?("../")
  		end 
  	end 
  	hash[:profile_quote] = doc.css(".profile-quote").text
  	hash[:bio] = doc.css(".description-holder p").text
  	hash
  end

end

