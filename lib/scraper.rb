require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative './student.rb'

class Scraper
  @@array = []

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("#{index_url}"))
    roster = doc.css(".roster-cards-container")
    roster.css(".student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
      @@array << {name: "#{name}", location: "#{location}", profile_url: "./fixtures/student-site/" + "#{profile_url}"}
    end
    @@array
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open("#{profile_url}"))
    if html.css(".social-icon-container").css("a").length == 1
      twitter = html.css(".social-icon-container").css("a")[0].attribute("href").value
    elsif html.css(".social-icon-container").css("a").length == 2
      linkedin = html.css(".social-icon-container").css("a")[0].attribute("href").value
      github = html.css(".social-icon-container").css("a")[1].attribute("href").value
      blog = nil
      twitter = nil
    elsif html.css(".social-icon-container").css("a").length == 3
      twitter = html.css(".social-icon-container").css("a")[0].attribute("href").value
      linkedin = html.css(".social-icon-container").css("a")[1].attribute("href").value
      github = html.css(".social-icon-container").css("a")[2].attribute("href").value
    elsif html.css(".social-icon-container").css("a").length == 4
      twitter = html.css(".social-icon-container").css("a")[0].attribute("href").value
      linkedin = html.css(".social-icon-container").css("a")[1].attribute("href").value
      github = html.css(".social-icon-container").css("a")[2].attribute("href").value
      blog = html.css(".social-icon-container").css("a")[3].attribute("href").value
    end
    profile_quote = html.css(".profile-quote").text
    bio = html.css(".bio-block p").text
    hash = Hash.new
    hash[:twitter] ||= twitter
    hash[:linkedin] ||= linkedin
    hash[:github] ||= github
    hash[:blog] ||= blog
    hash[:profile_quote] ||= profile_quote
    hash[:bio] ||= bio
    hash
    # {twitter: "#{twitter}",linkedin: "#{linkedin}", github: "#{github}", blog: "#{blog}" || nil, profile_quote: "#{profile_quote}", bio: "#{bio}"}
  end
end
