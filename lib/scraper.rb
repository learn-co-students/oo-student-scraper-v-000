require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	student_array = []
  	doc = Nokogiri::HTML(File.read(index_url))
    students = doc.css('.student-card')
    students.each do |student|
    	student_array << {
    		:name => student.css('h4').text,
    		:location => student.css('.student-location').text,
    		:profile_url => "./fixtures/student-site/#{student.css('a').attribute("href").value}"
    	}
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
  	social_networks = ["facebook", "github", "twitter", "linkedin"]
    doc = Nokogiri::HTML(File.read(profile_url))
    social_links = doc.css('.social-icon-container a')
    student_hash = {}
    social_links.each do |link|
    	link_url = link.attribute('href').value
    	key = link_url.include?("www") ? link_url.split('.')[1] : link_url.split(".com")[0].split("//")[1]
    	if social_networks.include?(key)
    		student_hash[key.to_sym] = link_url
    	else
    		student_hash[:blog] = link_url
    	end
    end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text
    student_hash
  end

end



