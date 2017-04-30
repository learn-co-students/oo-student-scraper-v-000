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
    profiles = Nokogiri::HTML(open(profile_url))

    profiles.css("div.main-wrapper profile").each do |i|

      details_hash = {
        binding.pry
      :twitter => i.css("div.vitals-container div.social-icon-container a")[0].attribute("href").text,
      :linkedin => i.css("div.vitals-container div.social-icon-container a")[1].attribute("href").text,
      :github => i.css("div.vitals-container div.social-icon-container a")[2].attribute("href").text,
      :blog => i.css("a div.card-text-container h4.student-name").text,
      :profile_quote => i.css("div.vitals-text-container div.profile-quote").text,
      :bio => i.css("div.details-container div.bio-block details-block div.bio-content content-holder div.description-holder p").text
      }
    end
  end

end

# Scraper.new
