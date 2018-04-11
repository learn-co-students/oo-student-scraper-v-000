require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :doc
  @@student_index_array = []

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |card|
      student_info = {}
      student_info[:name] = card.css(".card-text-container .student-name").text
      student_info[:location] = card.css(".card-text-container .student-location").text
      student_info[:profile_url] = card.css("a[href]").first['href']
      @@student_index_array << student_info
    end
    @@student_index_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    doc = Nokogiri::HTML(open(profile_url))

    #scraping social media

    doc.css(".social-icon-container a").each do |social_media_deets|
      if social_media_deets['href'].include?('twitter')
        student_profile[:twitter] = social_media_deets['href']
      elsif social_media_deets['href'].include?('linkedin')
        student_profile[:linkedin] = social_media_deets['href']
      elsif social_media_deets['href'].include?('github')
        student_profile[:github] = social_media_deets['href']
      else
        student_profile[:blog] = social_media_deets['href']
      end
    end

    #profile quote
      student_profile[:profile_quote] = doc.css(".profile-quote").text

    #bio
      student_profile[:bio] = doc.css(".description-holder p").text

    student_profile
  end

end
