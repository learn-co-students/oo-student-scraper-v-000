require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").map do |student|
    	{
    		name: student.css("h4").text,
    		location: student.css("p").text,
    		profile_url: "./fixtures/student-site/" + student.css("a").attribute("href").value
    	}
    end
  end

  def self.scrape_profile_page(profile_url)
  	doc = Nokogiri::HTML(open(profile_url))

  	profile = {}
    doc.css("div.social-icon-container a").each do |link|
    	link_value = link.attribute("href").value
    	if link_value.include?("twitter")
    		profile[:twitter] = link_value
    	elsif link_value.include?("linkedin")
    		profile[:linkedin] = link_value
    	elsif link_value.include?("github")
    		profile[:github] = link_value
    	else
    		profile[:blog] = link_value
    	end
    end

    profile[:profile_quote] = doc.css(".profile-quote").text
    profile[:bio] = doc.css(".description-holder p").text

    profile
  end

end

