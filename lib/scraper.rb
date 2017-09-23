require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students_array = [] # array to store student hashes

    doc.css("div.student-card").each do |card| # iterate through cards, create hash for individual
      students_array << {                      # students, select elements, push hash to students_array
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open (profile_url)
    doc = Nokogiri::HTML(html)
    profile_hash = {}
    # iterates through social icon container and collects available data 
    doc.css("div.social-icon-container a").each do |item|
        # twitter
      if item.attribute("href").value.include?("twitter")
        profile_hash[:twitter] = item.attribute("href").value
        # linkedin
      elsif item.attribute("href").value.include?("linkedin")
        profile_hash[:linkedin] = item.attribute("href").value
        # github
      elsif item.attribute("href").value.include?("github")
        profile_hash[:github] = item.attribute("href").value
        # blog
      elsif item.css("img.social-icon").attribute("src").value.include?("rss-icon")
        profile_hash[:blog] = item.attribute("href").value
      end
    end
    # profile quote
    profile_hash[:profile_quote] = doc.css("div.profile-quote").text
    # bio
    profile_hash[:bio] = doc.css("div.description-holder p").text
    profile_hash
  end
end
