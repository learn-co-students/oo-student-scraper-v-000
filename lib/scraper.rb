require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    require "nokogiri"
    html = File.read(index_url)
    site_index = Nokogiri::HTML(html)
    site_index.encoding = 'UTF-8'

    site_index.css(".student-card").map do |card|
      {
        :name => card.css(".student-name").text,
        :location => card.css(".student-location").text,
        :profile_url => card.css("a").attr("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    require "nokogiri"
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)

    profile_hash = {
      :profile_quote => profile.css(".profile-quote").text,
      :bio => profile.css(".description-holder p").text
    }

    profile.css(".social-icon-container a").each do |social_links|
      url = social_links.attr("href")
      if url.include?("twitter")
        profile_hash[:twitter] = url
      elsif url.include?("github")
        profile_hash[:github] = url
      elsif url.include?("youtube")
        profile_hash[:youtube] = url
      elsif url.include?("linkedin")
        profile_hash[:linkedin] = url
      else
        profile_hash[:blog] = url
      end
    end
    profile_hash
  end

end
