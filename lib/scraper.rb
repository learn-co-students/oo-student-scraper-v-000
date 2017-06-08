require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	scrape_hash_array = []
  	cards = {}
  	index_page = Nokogiri::HTML(open(index_url))
  	index_page.css("div.student-card").each do |card|
  		cards[card.text.to_sym] = {
      		:name => card.css("h4").text,
      		:location => card.css("p").text,
      		:profile_url => card.css("a").attribute("href").value
    	}
    	scrape_hash_array << cards[card.text.to_sym]
  	end
  	scrape_hash_array   
  end

  def self.scrape_profile_page(profile_url)
  	profile_hash_array = []
  	details = {}
  	twitter = ""
  	linkedin = ""
  	github = ""
  	blog = ""
  	profile_page = Nokogiri::HTML(open(profile_url))
  	profile_page.css("body").each do |info|
  		info.css("div.social-icon-container a").each do |social|
  			twitter = social.attribute("href").value if social.attribute("href").value.include?("twitter")
  			linkedin = social.attribute("href").value if social.attribute("href").value.include?("linkedin")
  			github = social.attribute("href").value if social.attribute("href").value.include?("github")
  			blog = social.attribute("href").value if !social.attribute("href").value.include?("github") && !social.attribute("href").value.include?("linkedin") && !social.attribute("href").value.include?("twitter")
  		end
  		details = {
  			:bio => info.css("div.description-holder p").text,
  			:blog => blog,
  			:github => github,
  			:linkedin => linkedin,
  			:profile_quote => info.css("div.profile-quote").text,
  			:twitter => twitter
  		}.reject{ |k,v| v == "" }
  	end
  	details
    
  end

end

