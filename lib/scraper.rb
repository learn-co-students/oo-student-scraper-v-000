require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    profiles = []

    doc.css(".student-card").each do |profile|
       info = {
         :name => profile.css(".student-name").text,
         :location => profile.css(".student-location").text,
         :profile_url => profile.css("a").attr("href").value
        }
      profiles << info
      end
    profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
      nodeset = doc.css(".social-icon-container a[href]")
      hrefs = nodeset.map {|element| element["href"]}
      info = {}
      hrefs.each do |link|
        if link.include?('twitter')
          info[:twitter] = link
        elsif link.include?('linkedin')
          info[:linkedin] = link
        elsif link.include?('github')
          info[:github] = link
        else
          info[:blog] = link
        end
      end
      info[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      info[:bio] = doc.css(".description-holder p").text
      info
  end
end

# Scraper.scrape_profile_page
# Scraper.scrape_index_page
