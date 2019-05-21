require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    scraped_students = []
    students.css("div.student-card a").each do |student|
     name = student.css(".student-name").text
     location = student.css(".student-location").text
     url = "#{student["href"]}"
     scraped_students << {name: name, location: location, profile_url: url}
   end
   scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profiles = Nokogiri::HTML(open(profile_url))
    scraped_profiles = {}
    profiles.css(".social-icon-container a").each do |profile|
      if profile["href"].include?("twitter")
        scraped_profiles[:twitter] = profile["href"]
      elsif profile["href"].include?("linkedin")
        scraped_profiles[:linkedin] = profile["href"]
      elsif profile["href"].include?("github")
        scraped_profiles[:github] = profile["href"]
      else
        scraped_profiles[:blog] = profile["href"]
      end
    end
    scraped_profiles[:profile_quote] = profiles.css(".profile-quote").text
    scraped_profiles[:bio] = profiles.css(".description-holder p").text
    scraped_profiles
  end

end
