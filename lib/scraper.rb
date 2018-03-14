require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    # The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be :name, :location and :profile_url
    html = Nokogiri::HTML(open(index_url))
    array = []
    html.css("div.roster-cards-container div.student-card").each do |card|
      hash = {}
      hash[:name] = card.css("a .card-text-container h4.student-name").text
      hash[:location] = card.css("a .card-text-container p.student-location").text
      hash[:profile_url] = "./fixtures/student-site/" + card.css("a")[0]["href"]
      array << hash
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    hash = {}
    html.css("div.vitals-container div.social-icon-container a").each do |icon|
      if !icon["href"].nil? && icon["href"].include?(".com")
        media_name = icon["href"].scan(/[a-zA-Z]+.com/)[0].chomp(".com")
        # media_name = "blog" if media_name == "rss"
        media_name = media_name.to_sym
        # binding.pry
        if Student.method_defined?(media_name)
          hash[media_name.to_sym] = icon["href"]
        else
          hash[:blog] = icon["href"]
        end
      end
    end
    hash[:profile_quote] = html.css("div.vitals-text-container div.profile-quote").text
    hash[:bio] = html.css("div.bio-content div.description-holder p").text
    hash
  end

end
