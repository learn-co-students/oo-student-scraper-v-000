require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = Nokogiri::HTML(open("http://students.learn.co/"))

    profiles_array = []

    profiles.css("div.roster-cards-container").each do |profile|
      profile.css("div.student-card").each do |i|
      # info = profile.css("div.student-card").text
      profiles_hash = {
      :name => i.css("a div.card-text-container h4.student-name").text,
      :location => i.css("a div.card-text-container p.student-location").text,
      :profile_url => "./fixtures/student-site/" + i.css("a").attribute("href").text
      }
        profiles_array << profiles_hash
         end
       end
      profiles_array
    end

  def self.scrape_profile_page(profile_url)
    info = Nokogiri::HTML(open(profile_url))

      details_hash = {
      :twitter => info.css("div.social-icon-container a").attribute("href").text,
      :linkedin => info.css("div.social-icon-container a")[1].attribute("href").text,
      :github => info.css("div.social-icon-container a")[2].attribute("href").text,
      :blog => info.css("div.social-icon-container a")[3].attribute("href").text,
      :profile_quote => info.css("div.vitals-text-container div.profile-quote").text,
      :bio => info.css("div.description-holder p").text
      }
      details_hash
  end


end

# Scraper.new
