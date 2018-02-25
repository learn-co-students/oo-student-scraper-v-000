require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    page = Nokogiri::HTML(html)

    page.css(".student-card").each do |item|
      student = Hash.new
      student[:name] = item.css(".student-name").text
      student[:location] = item.css(".student-location").text
      student[:profile_url] = item.css("a")[0]["href"]
      students << student
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Hash.new
    html = open(profile_url)
    page = Nokogiri::HTML(html)

    if page.css(".social-icon-container")
      page.css(".social-icon-container a").each do |a|
        social = a["href"]
        if social.include?("twitter")
          profile[:twitter] = social
        elsif social.include?("linkedin")
          profile[:linkedin] = social
        elsif social.include?("github")
          profile[:github] = social
        else
          profile[:blog] = social
        end
      end
    end

    if page.css(".profile-quote")
      profile[:profile_quote] = page.css(".profile-quote").text
    end

    if page.css(".bio-content")
      profile[:bio] = page.css(".bio-content p").text
    end

    profile
  end

end
