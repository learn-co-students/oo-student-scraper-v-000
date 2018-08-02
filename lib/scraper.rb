require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn = Nokogiri::HTML(html)
    students = []

    learn.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: student.css("a").attr("href").text
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    profile = Nokogiri::HTML(html)
    profile_info = {}
    social_links = []

    social_media = profile.css("div.social-icon-container a")
    social_media.each do |site|
      social_links << site.attr("href")
    end

    social_links.each do |link|
      profile_info[:twitter] = link if link.include?("twitter")
      profile_info[:linkedin] = link if link.include?("linkedin")
      profile_info[:github] = link if link.include?("github")
      profile_info[:blog] = link if !link.include?("twitter") &&
      !link.include?("linkedin") && !link.include?("github")
    end

    profile_info[:profile_quote] = profile.css("div.profile-quote").text
    profile_info[:bio] = profile.css("div.description-holder p").text

    profile_info
  end

end
