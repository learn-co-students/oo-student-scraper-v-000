require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("http://127.0.0.1:4000/"))
    student_index_array = []
    doc.css(".student-card").each do |student|
    	student_url = "http://127.0.0.1:4000/" + student.css("a")[0]["href"]
	    student_index_array << 
	    {:name => student.css("h4").text,
	     :location => student.css("p").text,
	     :profile_url => student_url}	
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
  	scraped_student = {}

		doc.css(".social-icon-container a").each do |social_url|
  		if social_url["href"].match("twitter")
		  	scraped_student[:twitter] = social_url["href"]
			elsif social_url["href"].match("linkedin")
		  	scraped_student[:linkedin] = social_url["href"]
			elsif social_url["href"].match("github")
		  	scraped_student[:github] = social_url["href"]
  		elsif social_url["href"].match("http")
		  	scraped_student[:blog] = social_url["href"]
			end 	
  	end
  	
  	scraped_student[:profile_quote] = doc.css(".profile-quote").text
  	scraped_student[:bio] = doc.css("p").text
    scraped_student
  end
end