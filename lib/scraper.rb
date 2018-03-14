require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
    info_arr = []
    index_html = Nokogiri::HTML(open(index_url))
    index_html.css("div.student-card").each do |student|
      info = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
      info_arr << info
    end
    return info_arr
  end

  def self.scrape_profile_page(profile_url)
    info_hash = {}
    profile_html = Nokogiri::HTML(open(profile_url))
    info_hash[:bio] = profile_html.css("div.description-holder p").text
    info_hash[:profile_quote] = profile_html.css("div.profile-quote").text
    profile_html.css("div.social-icon-container a").each do |link|
      if link["href"].include?("twitter")
        info_hash[:twitter] = link["href"]
      elsif link["href"].include?("linkedin")
        info_hash[:linkedin] = link["href"]
      elsif link["href"].include?("github")
        info_hash[:github] = link["href"]
      else
      info_hash[:blog] = link["href"]
      end
    end
    return info_hash
  end

end
