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

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    profile.css("div.social-icon-container").each do |icon|
    	social_links = profile.css("a[href]").map{|element|element["href"]}
    	binding.pry
    end 
  end

end

