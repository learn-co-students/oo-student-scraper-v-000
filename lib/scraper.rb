require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = Nokogiri::HTML(open("http://students.learn.co/"))

    profiles_hash = {}

    profiles_hash.css("div.student-card").each do |profile|
      info = profile.css("").text
      profile[info.to_sym] = {
      :name => profile.css("a div.card-text-container h4.student-name").text,
      :location => profile.css("p.student-location").text,
      :profile_url => profile.css("ul.project-meta span.location-name").text
        }
   end
  profiles_hash
  end

  def self.scrape_profile_page(profile_url)

  end

end

Scraper.new
