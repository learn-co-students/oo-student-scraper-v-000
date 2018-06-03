# require 'Nokogiri'
require 'open-uri'
require 'pry'

class Scraper #responsible for scraping the data from a webpage

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card a").each do |doc|
    student = {
      name: doc.css(".student-name").text,
      location: doc.css("p.student-location").text,
      profile_url: doc.attr("href") #attribute
    }
      students << student
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
        profile = []
        social_media = {}
    links = doc.css(".social-icon-container a").each do |link|
      profile << link["href"]
    end
		  profile.each do|link|
		  if link.include?("twitter")
				social_media[:twitter] = link
			elsif link.include?("linkedin")
				social_media[:linkedin] = link
			elsif link.include?("github")
				social_media[:github] = link
			else
				social_media[:blog] = link
			end
		end
		social_media[:profile_quote] = doc.css("div.profile-quote").text
    social_media[:bio] = doc.css(".description-holder").first.text.strip!
    #binding.pry
		social_media
	end

end
