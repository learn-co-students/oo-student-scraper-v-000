require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []

    doc.css(".student-card").each do |s|

      student = {}
      student[:name] = s.css('.card-text-container h4.student-name').text
      student[:location] = s.css('.card-text-container p.student-location').text
      student[:profile_url] = s.css('a').attribute('href').value
      students << student
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    profile = {}

    doc.css(".social-icon-container a").each do |s|
      if s.attribute("href").value.include?("twitter")
        profile[:twitter]=s.attribute("href").value
      elsif s.attribute("href").value.include?("linkedin")
        profile[:linkedin]=s.attribute("href").value
      elsif s.attribute("href").value.include?("github")
        profile[:github]=s.attribute("href").value
      else s.attribute("href").value.include?("blog")
        profile[:blog]=s.attribute("href").value
      end
    end
    profile[:profile_quote]=doc.css(".profile-quote").text
    profile[:bio]=doc.css(".bio-block").css("p").text
    profile
  end

end
