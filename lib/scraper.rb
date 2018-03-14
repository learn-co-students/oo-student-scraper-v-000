require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        profile_link = "#{student.attr('href')}"
        location = student.css(".student-location").text
        name = student.css(".student-name").text
        student = {
          name: name,
          location: location,
          profile_url: profile_link
        }

        scraped_students << student

      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profiles = Nokogiri::HTML(html)

    scraped_student = {}

    scraped_student[:profile_quote] = profiles.css(".profile-quote").text
    scraped_student[:bio] = profiles.css(".bio-content p").text

    profiles.css(".social-icon-container a").each do |links|
      link = "#{links.attr("href")}"

      if link.include?("twitter")
        scraped_student[:twitter] = link
      elsif link.include?("linkedin")
      scraped_student[:linkedin] = link
      elsif link.include?("github")
        scraped_student[:github] =link
      else link.include?("blog")
      scraped_student[:blog] = link
      end
    end
    scraped_student
  end




end





#notes for myself:
#1. first things first, run bundle install, then gem install nokogiri
#2. need to: require "open-uri" and require "nokogiri" at the top
#3. set html variable to open(url) to make it simple. in this case, URL has been assigned in specs via:
#3a. index_url = "./fixtures/student-site/index.html"
#doc.css("div.roster-cards-container").each do |card| < go through all cards for each card
#card.css(".student-card a").each do |student| < go through each card to grab student
#profile_link is set to the variable of the css selector for viewing profile.
