require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    page = Nokogiri::HTML(html)
    scraped_students = []

    page.css(".student-card a").each do |student|
      info = {}
      info[:name] = student.css(".student-name").text
      info[:location] = student.css(".student-location").text
      info[:profile_url] = "./fixtures/student-site/#{student.attr('href')}"
      scraped_students << info
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    page = Nokogiri::HTML(html)
    attributes_hash = {}
    social = page.css(".social-icon-container a")
    social.each do |link|
      if link["href"].include? "twitter"
        attributes_hash[:twitter] = link["href"]
      elsif link["href"].include? "linkedin"
        attributes_hash[:linkedin] = link["href"]
      elsif link["href"].include? "github"
        attributes_hash[:github] = link["href"]
      else
        attributes_hash[:blog] = link["href"]
      end
    end
    attributes_hash[:profile_quote] = page.css(".profile-quote").text
    attributes_hash[:bio] = page.css(".description-holder p").text
    attributes_hash
  end
end
