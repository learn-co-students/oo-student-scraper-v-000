require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open("#{index_url}"))
    html.css("div.student-card").collect do |card|
      {name: card.css("h4.student-name").text,
        location: card.css("p.student-location").text,
        profile_url: card.css("a").attribute("href").value}
      end
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open("#{profile_url}"))
      profile_hash = {}
    html.css("div.social-icon-container a").each do |social|
      if social.css("img.social-icon").attribute("src").value == "../assets/img/twitter-icon.png"
        profile_hash[:twitter] = social.attribute("href").value
      elsif social.css("img.social-icon").attribute("src").value == "../assets/img/linkedin-icon.png"
        profile_hash[:linkedin] = social.attribute("href").value
      elsif social.css("img.social-icon").attribute("src").value == "../assets/img/github-icon.png"
        profile_hash[:github] = social.attribute("href").value
      elsif social.css("img.social-icon").attribute("src").value == "../assets/img/rss-icon.png"
        profile_hash[:blog] = social.attribute("href").value
      end
    end
      profile_hash[:profile_quote] = html.css("div.profile-quote").text
      profile_hash[:bio] = html.css("div.description-holder p").text
      profile_hash
  end
end
