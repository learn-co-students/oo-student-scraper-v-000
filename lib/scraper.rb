require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    names = doc.css("h4.student-name").map{|e| e.text}
    location = doc.css("p.student-location").map{|e| e.text}
    profile_url = doc.css("div.student-card a").map{|e| "./fixtures/student-site/" + e.attribute("href").value}
    temp = []
    names.each_with_index do |name, index|
    	temp << {name: name, location: location[index], profile_url: profile_url[index]}
    end

    temp
  end

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
     social_links = doc.css("div.social-icon-container a").map{|e| e.attribute("href").value}
     dict = {}
     social_links.each do |site|
     	if site.include?("twitter")
     		dict[:twitter] = site
     	elsif site.include?("github")
     		dict[:github] = site
     	elsif site.include?("linkedin")
     		dict[:linkedin] = site
     	else
     		dict[:blog] = site
     	end
     end 
     dict[:profile_quote] = doc.css("div.profile-quote").text
     dict[:bio] = doc.css("div.description-holder p").text
     dict
  end

end

