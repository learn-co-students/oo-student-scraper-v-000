require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    Nokogiri::HTML(open(index_url)).css(".student-card").each { |student_card| array << {name: student_card.css(".student-name").text, location: student_card.css(".student-location").text, profile_url: "http://127.0.0.1:4000/#{student_card.css("a").attribute("href").value}"} }
    array
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    hash = {profile_quote: profile.css(".profile-quote").text, bio: profile.css(".bio-content p").text}
    profile.css(".social-icon-container a").each do |social_item|
      link = social_item.attribute("href").value
      case social_item.css("img").attribute("src").value
      when "../assets/img/twitter-icon.png"
        hash[:twitter] = link
      when "../assets/img/linkedin-icon.png"
        hash[:linkedin] = link
      when "../assets/img/github-icon.png"
        hash[:github] = link
      when "../assets/img/rss-icon.png"
        hash[:blog] = link
      end
    end
    hash
  end

end
