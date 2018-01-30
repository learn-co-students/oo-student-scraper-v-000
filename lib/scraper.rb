require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    Nokogiri::HTML(open(index_url)).css("div .student-card").map do |student_card|
      {
        name: student_card.css(".student-name").text,
        location: student_card.css(".student-location").text,
        profile_url: student_card.css("a")[0]["href"]
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    scraped_profile = {profile_quote: page.css(".profile-quote").text, bio: page.css(".bio-content .description-holder p").text}
    social_icons = page.css(".social-icon-container a")
    social_icons.each do |social_icon|
      if social_icon.css("img")[0]["src"] == "../assets/img/twitter-icon.png"
        scraped_profile[:twitter] = social_icon["href"]
      elsif social_icon.css("img")[0]["src"] == "../assets/img/linkedin-icon.png"
        scraped_profile[:linkedin] = social_icon["href"]
      elsif social_icon.css("img")[0]["src"] == "../assets/img/github-icon.png"
        scraped_profile[:github] = social_icon["href"]
      elsif social_icon.css("img")[0]["src"] == "../assets/img/rss-icon.png"
        scraped_profile[:blog] = social_icon["href"]
      end
    end
    scraped_profile
  end

end
