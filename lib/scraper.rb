require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    profiles = doc.css(".student-card")
    profiles.each do |profile|
      fields = {}
      fields[:name] = profile.css(".student-name").text
      fields[:location] = profile.css(".student-location").text
      fields[:profile_url] = profile.css('a')[0]['href']
      students << fields
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    social_media = []
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css(".social-icon-container")
    links.each do |link|
      fields = {}
      fields[:linkedin] = profile.css('a')[0]['href']
      binding.pry
    end

  end

end
