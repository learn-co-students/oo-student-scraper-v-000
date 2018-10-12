require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    profiles = Nokogiri::HTML(html)
    students = []
    profiles.css("div.student-card").each do |student|
      students << {:name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").text}
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profiles = Nokogiri::HTML(html)
    profile_hash = {}
    profiles.css("div.social-icon-container").css("a").each do |student|
      if student.attribute("href").text.include?("twitter")
        profile_hash[:twitter] = student.attribute("href").text
      elsif student.attribute("href").text.include?("linkedin")
        profile_hash[:linkedin] = student.attribute("href").text
      elsif student.attribute("href").text.include?("github")
        profile_hash[:github] = student.attribute("href").text
      else 
        profile_hash[:blog] = student.attribute("href").text
        end
      end
      if profiles.css("div.profile-quote") != []
        profile_hash[:profile_quote] = profiles.css("div.profile-quote").text
      if profiles.css("div.description-holder p") != []
        profile_hash[:bio] = profiles.css("div.description-holder p").text
      end
      end
      profile_hash
  end
end

# Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/students/joe-burgess.html")