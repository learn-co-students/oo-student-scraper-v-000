require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	html = File.read(index_url)
  	student_index = Nokogiri::HTML(html)

  	scraped_students = []

  	student_index.css(".roster-cards-container").each do |roster|
  		scraped_students = roster.css("div.student-card").collect do |student|
  			{
  			:name => student.css("h4.student-name").text, 
  			:location => student.css("p.student-location").text,
  			:profile_url => student.css("a").attribute("href").value
  		}
  		end
  	end
   scraped_students
  end

  def self.scrape_profile_page(profile_url)
  	html = File.read(profile_url)
student_page = Nokogiri::HTML(html)
student_links = {}
  	student_page.css("div.social-icon-container a").each do |link|
  		if link.css("img").attribute("src").value == "../assets/img/twitter-icon.png"
  			student_links[:twitter] = link.attribute("href").value
  		elsif link.css("img").attribute("src").value =="../assets/img/linkedin-icon.png"
  			student_links[:linkedin] = link.attribute("href").value
        
  		elsif link.css("img").attribute("src").value == "../assets/img/github-icon.png"
  			student_links[:github] = link.attribute("href").value
  		elsif link.css("img").attribute("src").value == "../assets/img/rss-icon.png"
  			student_links[:blog] = link.attribute("href").value
  		end	
  	end
  	student_links[:profile_quote] = student_page.css("div.profile-quote").text
  	student_links[:bio] = student_page.css("div.description-holder p").text
  	student_links
  end

end










