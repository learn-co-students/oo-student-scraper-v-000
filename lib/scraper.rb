require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    
    profiles = []
    
    page.css(".student-card").each do |profile|
      new_profile = {
        :name => profile.css(".student-name").text
        :location => profile.css(".student-location").text
        :profile_url => profile.first.css("a").attribute("href").value
        }
      profiles << new_profile
    end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

