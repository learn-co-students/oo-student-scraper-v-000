require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    #iterate through the profiles
    doc.css(".student-card").map do |profile|
    	profiles = {
    		name: profile.css(".student-name").text,
    		location: profile.css(".student-location").text,
    		profile_url: "./fixtures/student-site/" << profile.css("a").attribute("href").value
    	}
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    #iterate through the profiles
    profiles = {}
    doc.css(".social-icon-container a").each do |profile|
    	if profile.attr("href").include?("twitter")
    		profiles[:twitter] = profile.attr("href")
    	elsif profile.attr("href").include?("linkedin")
    		profiles[:linkedin] = profile.attr("href")
    	elsif profile.attr("href").include?("github")
    		profiles[:github] = profile.attr("href")
    	elsif profile.attr("href")
    		profiles[:blog] = profile.attr("href")
    	end
    	profiles[:profile_quote] = doc.css(".profile-quote").text
    	profiles[:bio] = doc.css(".description-holder p").text
    end
    profiles
  end
end

