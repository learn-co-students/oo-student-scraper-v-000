require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page_array = []
    profile_url_array = []

    html = open(index_url)
    doc = Nokogiri::HTML(html)

    doc.css(".card-text-container").each do |student_profile|
      person = {}
      student_name = student_profile.css("h4").text
      student_location = student_profile.css("p").text
      person[:name] = student_name
      person[:location] = student_location
      index_page_array << person
    end

    doc.css(".student-card a").each do |student_profile|
      person = {}
      student_link = student_profile.attributes["href"].value
      profile_url_array << student_link
    end

    i = 0

    index_page_array.each do |hash|
      hash[:profile_url] = profile_url_array[i]
      i += 1
    end

    return index_page_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile_hash = {}

    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    doc.css(".social-icon-container a").each do |icon|
      social_media_link = icon.attributes["href"].value
      if social_media_link.match(/.+twitter..+/)
        student_profile_hash[:twitter] = social_media_link
      elsif social_media_link.match(/.+linkedin..+/)
        student_profile_hash[:linkedin] = social_media_link
      elsif social_media_link.match(/.+github..+/)
        student_profile_hash[:github] = social_media_link
      else
        student_profile_hash[:blog] = social_media_link
      end
    end

    doc.css(".profile-quote").each do |quote|
      profile_quote = quote.text
      student_profile_hash[:profile_quote] = profile_quote
    end

    doc.css(".description-holder p").each do |bio|
      bio_text = bio.text
      student_profile_hash[:bio] = bio_text
    end

    return student_profile_hash
  end

end
