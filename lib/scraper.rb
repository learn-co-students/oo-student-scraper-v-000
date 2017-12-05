require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_reader :index_url

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    doc.css("div.student-card").each do |card|
      name = card.css("h4.student-name").text
      location = card.css("p.student-location").text
      url = card.css("a").attribute("href").value
      student = {
        :name => name,
        :location => location,
        :profile_url => url
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_sites = doc.css(".social-icon-container a")
    social_links = social_sites.collect{|s| s.attribute("href").value}
    student = {}
    social_links.each do |s|
      if s.include?("twitter")
        student[:twitter] = s
      elsif s.include?("linkedin")
        student[:linkedin] = s
      elsif s.include?("github")
        student[:github] = s
      elsif s.include?("facebook") || s.include?("youtube")
      else
        student[:blog] = s
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("div.description-holder p").text
    student
  end

end

Scraper.scrape_profile_page("./fixtures/student-site/students/ryan-johnson.html")
