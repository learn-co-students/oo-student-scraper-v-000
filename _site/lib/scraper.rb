require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc=Nokogiri::HTML(open("http://159.203.117.55:3081/"))
    scraped_students=Array.new
    doc.css(".student-card").each do |info|
    hash={
      :name => info.css(".student-name").text,
      :location => info.css(".student-location").text,
      :profile_url => "http://127.0.0.1:4000/" + info.css("a").attr('href').value
    }
    scraped_students << hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc=Nokogiri::HTML(open("profile_url"))
    hash={}
    doc.css(".social-icon-container a").each do |info|
      if info.attr('href').include?("twitter")
        hash[:twitter] = info.attr('href')
      elsif info.attr('href').include?("linkedin")
        hash[:linkedin] = info.attr('href')
      elsif info.attr('href').include?("github")
        hash[:github] = info.attr('href')
      elsif info.attr('href').include?("blog")
        hash[:blog] = info.attr('href')
      end
    end
  end

end
