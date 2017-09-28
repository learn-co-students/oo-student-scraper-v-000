require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []
    doc.css(".student-card").each do |card|
      student = {
        :name => card.css(".student-name").text,
        :location => card.css(".student-location").text,
        :profile_url => card.css("a").attribute("href").value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    profile = {
      :twitter => '',
      :linkedin => '',
      :github => '',
      :blog => '',
      :profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder p").text
         }

    doc.css(".social-icon-container a").each do |social|
      social_url = social.attribute("href").value
      if social_url.include?("twitter")
        profile[:twitter] = social_url
      elsif social_url.include?("linkedin")
        profile[:linkedin] = social_url
      elsif social_url.include?("github")
        profile[:github] = social_url
      elsif social_url.include?("blog")
        profile[:blog] = social_url
      end
    end
      binding.pry
    profile
  end

end

Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")
