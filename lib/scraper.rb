require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url = 'http://127.0.0.1:4000' )
  	students = []
  	
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
    	students << {
          :name => student.css(".card-text-container h4").text,
          :location => student.css(".card-text-container p").text,
          :profile_url => index_url + student.css("a").attribute("href").value
    	}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
  	doc = Nokogiri::HTML(open(profile_url))
  	 profile = {
       :twitter => doc.css(".social-icon-container a").detect{|item| item.attribute("href").text.include?("twitter")},
       :linkedin => doc.css(".social-icon-container a").detect{|item| item.attribute("href").text.include?("linkedin")},
       :github => doc.css(".social-icon-container a").detect{|item| item.attribute("href").text.include?("github")},
       :blog => doc.css(".social-icon-container a").detect{|item| !item.attribute("href").text.include?("twitter") && !item.attribute("href").text.include?("linkedin") &&  !item.attribute("href").text.include?("github")},
       :profile_quote => doc.css(".profile-quote").text,
       :bio => doc.css(".description-holder p").text
  	}
    profile
    profile.delete_if{|key, value| value == nil}
    profile_new = profile.each do |key, value|
      if key == :twitter || key == :linkedin || key == :github || key == :blog
       profile[key] = value.attribute("href").value
      end
    end
    profile_new
  end

end

