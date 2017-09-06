require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	students = []
    html = File.read(index_url)
    profile_index = Nokogiri::HTML(html)
    profile_index.css("div.student-card").each do |thumbnail|
    	student_hash = {}
    	name = thumbnail.css("h4.student-name").text
    	location = thumbnail.css("p.student-location").text
    	profile_url = thumbnail.css("a[href]").map{|element|element["href"]}
    	student_hash[:name] = name
    	student_hash[:location] = location
    	student_hash[:profile_url] = profile_url[0]
    	students << student_hash
    end
    students
  end


      # twitter url, linkedin url, github url, blog url, profile quote, and bio

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    student_hash = {}
    last_name = profile.css("h1.profile-name").text.split[-1].downcase
    student_hash[:profile_quote] = profile.css("div.profile-quote").text
    student_hash[:bio] = profile.css("div.description-holder p").text
    profile.css("div.social-icon-container").each do |icon|
    	social_links = profile.css("a[href]").map{|element|element["href"]}
    	social_links.each do |link|
    		if link.include?("twitter.com")
    			student_hash[:twitter] = link
    		elsif link.include? ("linkedin.com")
    			student_hash[:linkedin] = link
    		elsif link.include?("github.com")
    			student_hash[:github] = link	
    		elsif link.include?(last_name)
    			student_hash[:blog] = link
    		end #end of ugly if chain
    	end #end of social_links each
   	end
   	student_hash
   end

end

