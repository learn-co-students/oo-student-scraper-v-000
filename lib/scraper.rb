require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each {|profile|
      profile_hash = {}
      profile_hash[:name] = profile.css(".student-name").text
      profile_hash[:location] = profile.css(".student-location").text
      profile_hash[:profile_url] = index_url + profile.css("a").first["href"]
      profiles << profile_hash
    }
    profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    social_list = doc.css(".vitals-container .social-icon-container a").map {|link| link["href"]}
    social_list.each {|link|
      if link.include? "twitter"
        profile_hash[:twitter] = link
      elsif link.include? "linkedin"
        profile_hash[:linkedin] = link
      elsif link.include? "github"
        profile_hash[:github] = link
      elsif link.include? "facebook"
        profile_hash[:facebook] = link
      else
        profile_hash[:blog] = link
      end
    }
    profile_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text # quote
    profile_hash[:bio] = doc.css(".details-container .bio-content .description-holder p").text # bio

    profile_hash
  end

end

