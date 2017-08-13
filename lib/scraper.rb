require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    array = []
    file = doc.css("div.student-card")
    file.each do |student|
      array << {
        :name => student.css("h4").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a")[0]["href"]
      }
    end
    return array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_info = {}
    doc.css("div.social-icon-container a").each do |file|
      if file["href"].include?("twitter")
        social_info[:twitter] = file["href"]
      elsif file["href"].include?("linkedin")
        social_info[:linkedin] = file["href"]
      elsif file["href"].include?("github")
        social_info[:github] = file["href"]
      else
        social_info[:blog] = file["href"]
      end
    end
    social_info[:profile_quote] = doc.css("div.profile-quote").text
    social_info[:bio] = doc.css("div.description-holder p").text
    return social_info

  end

end
