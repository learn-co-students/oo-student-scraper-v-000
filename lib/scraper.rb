require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    profiles = Nokogiri::HTML(html)
    students = []

    profiles.css("div.student-card").each do |profile|
      students << {
        :name => profile.css("h4").text,
        :location => profile.css("p").text,
        :profile_url => profile.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    # profile.css("div.social-icon-container").first
    # twitter url profile.css("div.social-icon-container").first.css("a")[0].attribute("href").value
    # linkin url profile.css("div.social-icon-container").first.css("a")[1].attribute("href").value
    # github url profile.css("div.social-icon-container").first.css("a")[2].attribute("href").value
    # blog url profile.css("div.social-icon-container").first.css("a")[3].attribute("href").value
    # profile quote profile.css("div.profile-quote").text
    # bio profile.css("p").text

    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student = {}

    profile.css("div.social-icon-container a").each do |p|
      social = p.attribute("href").value
      if social.include?("twitter")
        student[:twitter] = social
      elsif social.include?("linkedin")
        student[:linkedin] = social
      elsif social.include?("github")
        student[:github] = social
      else
        student[:blog] = social
      end
    end

    student[:profile_quote] = profile.css("div.profile-quote").text
    student[:bio] = profile.css("p").text

    student
  end
  
end
