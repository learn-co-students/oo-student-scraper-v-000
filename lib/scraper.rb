require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
	students = Nokogiri::HTML(html)
	names = students.css("h4.student-name").map {|f| f.text} #name
	locations = students.css("p.student-location").map {|f| f.text}
	links = students.css("div.student-card").map {|f| f.css("a").attribute("href").value}

	array_of_students = []

	until names.empty?
		single_hash = {}
		single_hash[:name] = names.pop
		single_hash[:location] = locations.pop
		single_hash[:profile_url] = "http://students.learn.co/" + links.pop
		array_of_students << single_hash
	end

	array_of_students.reverse #refactor so i don't need to reverse
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
	profile = Nokogiri::HTML(html)

	twitter = profile.css("div.social-icon-container a")[0].attribute("href").value
	linkedin = profile.css("div.social-icon-container a")[1].attribute("href").value
	github = profile.css("div.social-icon-container a")[2].attribute("href").value
	blog = profile.css("div.social-icon-container a")[3].attribute("href").value
	profile_quote = profile.css("div.profile-quote").text
	bio = profile.css("div.description-holder p").text

	single_hash = {}

	single_hash[:twitter] = twitter
	single_hash[:linkedin] = linkedin
	single_hash[:github] = github
	single_hash[:blog] = blog
	single_hash[:profile_quote] = profile_quote
	single_hash[:bio] = bio

	single_hash
  end

end

