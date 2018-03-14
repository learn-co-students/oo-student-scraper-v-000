require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |card| {
      name: card.css("h4").text,
      location: card.css("p.student-location").text,
      profile_url: card.css("a").attribute("href").value
    }
    end
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    profile = {}
    profile[:profile_quote] = html.css(".profile-quote").text
    profile[:bio] = html.css(".bio-content p").text
    html.css(".social-icon-container a").each do |a|
      link = a["href"]
      if link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      elsif link.include?("twitter")
        profile[:twitter] = link
      else
        profile[:blog] = link
      end
    end
    profile
  end

end
