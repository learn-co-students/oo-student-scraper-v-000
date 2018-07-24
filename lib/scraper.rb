require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = Nokogiri::HTML(open(index_url))
    cards = index_url.css(".roster-cards-container .student-card")
    contents = []

    cards.each do |card|
      hash = {}
      hash[:name] = card.css("a .card-text-container h4").text.strip
      hash[:location] = card.css("a .card-text-container p").text.strip
      hash[:profile_url] = card.css("a").attribute("href").text.strip
      contents << hash
    end
    contents
  end

  def self.scrape_profile_page(profile_url)
    profile_url = Nokogiri::HTML(open(profile_url))

    vital_text = profile_url.css(".vitals-container .vitals-text-container")
    social = profile_url.css(".vitals-container .social-icon-container a")

    hash = {}

    hash[:profile_quote] = vital_text.css(".profile-quote").text.strip
    hash[:bio] = profile_url.css(".bio-content .description-holder p").text.strip
    social.each do |link|

      if link.attribute("href").text.match(/twitter.com/)
        hash[:twitter] = link.attribute("href").text
      elsif link.attribute("href").text.match(/github.com/)
        hash[:github] = link.attribute("href").text
      elsif link.attribute("href").text.match(/linkedin.com/)
        hash[:linkedin] = link.attribute("href").text
      else
        hash[:blog] = link.attribute("href").text
      end
    end
    hash
  end

end
