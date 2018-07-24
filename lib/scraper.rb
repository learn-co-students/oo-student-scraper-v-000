require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    roster_cards = []
    index_page.css(".student-card").each do |card|
      roster_cards << card = {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
    end
    roster_cards
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile = {}
    profile[:bio] = profile_page.css("div .description-holder p").text
    profile[:profile_quote] = profile_page.css("div .profile-quote").text
    profile_page.css(".social-icon-container a").each do |link|
      url = link.attribute("href").value
        if url.include?("twitter")
          profile[:twitter] = url
        elsif url.include?("linkedin")
          profile[:linkedin] = url
        elsif url.include?("github")
          profile[:github] = url
        else
          profile[:blog] = url
        end
    end
    profile
  end

end

