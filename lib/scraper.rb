require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(File.read(index_url))
    profiles = index_page.css("div.roster-cards-container div.student-card")
    students = []
    profiles.each do |profile|
      students << {
        :name => profile.css("h4.student-name").text,
        :location => profile.css("p.student-location").text,
        :profile_url => profile.css("a").first['href']
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_icon = doc.css(".social-icon-container")
    social_links = []

      social_icon.css("a").each do |social|
        social_links << social.attribute("href").value
      end
      is_blog = doc.css("vitals-text-container h1").text
    profile_hash = {}

    social_links.each do |links|
       profile_hash[:twitter] = links if links.include?("twitter")
       profile_hash[:linkedin] = links if links.include?("linkedin")
       profile_hash[:github] = links if links.include?("github")
       profile_hash[:blog] = links if links.include?((doc.css("div.vitals-container h1").text.downcase.split.first)) unless links.include?("link") 
    end

      profile_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
      profile_hash[:bio] = doc.css(".description-holder p").text

    profile_hash

      end

end

