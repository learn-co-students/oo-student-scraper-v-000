require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").collect do |card| 
      {name: card.css(".student-name").text,
      location: card.css(".student-location").text,
      profile_url: card.css("a")[0]["href"]}
    end
  end

=begin
    profile_items = {twitter: profile.css("div.social-icon-container a")[0]["href"],
      linkedin: profile.css("div.social-icon-container a")[1]["href"],
      github: profile.css("div.social-icon-container a")[2]["href"],
      blog: profile.css("div.social-icon-container a")[3]["href"],
      profile_quote: profile.css(".profile-quote").text,
      bio: profile.css(".description-holder p").text}
=end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = doc.css(".main-wrapper")
    profile_items = {}
    profile.css(".social-icon-container a").each do |social_icon|
      web_address = social_icon.attributes["href"].value
      case web_address.split(/((\/\/www\.|\/\/)|\.)/)[3]
        when "twitter"
          key = "twitter"
        when "linkedin"
          key = "linkedin"
        when "github"
          key = "github"
        else 
          key = "blog"
      end
      value = social_icon.attributes["href"].value
      profile_items[:"#{key}"] = value
    end
    profile_items[:profile_quote] = profile.css(".profile-quote").text
    profile_items[:bio] = profile.css(".description-holder p").text
    profile_items
  end
end