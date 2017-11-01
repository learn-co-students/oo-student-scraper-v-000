require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  attr_accessor :name, :location, :profile_url, :twitter, :linkedin, :github, :profile_quote, :bio, :blog

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |kids|
       student_data = {
        :name => kids.css("h4.student-name").text,
        :location => kids.css("p.student-location").text,
        :profile_url => kids.css("a").attribute("href").value
      }
      students << student_data
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}
      social = doc.css(".social-icon-container a").collect do |link|
        if link["href"].include?("twitter.com")
          profile[:twitter] = link["href"]
        elsif link["href"].include?("linkedin.com")
          profile[:linkedin] = link["href"]
        elsif link["href"].include?("github")
          profile[:github] = link["href"]
        else
          profile[:blog] = link["href"]
        end
      end
      profile[:bio] = doc.css(".description-holder p").text
      profile[:profile_quote] = doc.css(".profile-quote").text
      profile
  end
end
