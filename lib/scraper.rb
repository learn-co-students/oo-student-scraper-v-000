require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css(".roster-cards-container .student-card")
    
    students.collect do |student| 
    	{
    		:name => student.css("h4.student-name").text,
    		:location => student.css("p.student-location").text,
    		:profile_url => student.css("a").attribute("href").value
    	}
    end
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_links = doc.css(".social-icon-container a")
    student = {}
    social_links.each do |link|
    	link_url = link.attribute("href").value
    	blog = link_url.split(/.+[\/.](\w+)\.com.+/)[1]
    	if  blog != "github" && blog != "twitter" && blog != "linkedin"
    		student[:blog] = link_url
    	end
    	key = link_url.split(/.+[\/.](twitter|github|linkedin).+/)[1]
    	if key != nil
    		student[key.to_sym] = link_url
    	end
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".details-container .bio-block .description-holder p").text
    student
  end
end

