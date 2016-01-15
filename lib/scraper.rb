require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
  	index_page = Nokogiri::HTML(open(index_url))
  	student_info = index_page.css("div.student-card")
  	student_array =[]
  	student_info.each do |student|
  		student_hash = {}
  		student_hash[:name] = student.css("h4.student-name").text
  		student_hash[:location] = student.css("p.student-location").text
  		student_hash[:profile_url] = "http://students.learn.co/" + student.css("a")[0]["href"]
  		student_array << student_hash
  	end
  	student_array
  end

  def self.scrape_profile_page(profile_url)
  	profile_page = Nokogiri::HTML(open(profile_url))
  	profile_hash ={}
  	profile_hash[:blog] = profile_page.css("div.social-icon-container").css("a")[-1]['href']
  	
  	profile_hash[:twitter] = profile_page.css("div.social-icon-container").css("a").map do |a|
  		a['href'] if a['href'] =~ (/twitter/)
  	end.compact[0]
  	
  	profile_hash[:linkedin] = profile_page.css("div.social-icon-container").css("a").map do |a|
  		a['href'] if a['href'] =~ (/linkedin/)
  	end.compact[0]

  	
  	profile_hash[:github] = profile_page.css("div.social-icon-container").css("a").map do |a|
  		a['href'] if a['href'] =~ (/github/)
  	end.compact[0]

  	profile_hash[:bio] = profile_page.css("div.details-container div.description-holder > p").text
  	profile_hash[:profile_quote] = profile_page.css("div.profile-quote").text
  	binding.pry
  	profile_hash


  end

end

