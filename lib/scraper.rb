require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html) 
    students = doc.css(".student-card")
    students.map.with_index do |student, index|
      c = Hash.new
      c[:name] = student.css("h4").text
      c[:location] = student.css("p").text
      c[:profile_url] = "http://students.learn.co/" + students.xpath('//div/a/@href')[index].value
      c
    end
  end

  def self.scrape_profile_page(profile_url)
    social_attributes = %w(twitter linkedin github blog profile_quote bio)
    social_attributes = social_attributes.map {|attribute| attribute.to_sym }
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_links = doc.css(".social-icon-container a")
    quote = doc.css(".profile-quote").text
    quote = quote.delete(quote[0])
    profile_hash = Hash.new(nil)
    profile_hash[:bio] = quote if quote
    doc.css(".social-icon-container a").each {|attributes| profile_hash[:blog] = attributes["href"] if attributes.children.first["src"].include?("rss")}
    social_attributes.each do |attribute|
      social_links.each do |social_link|
        profile_hash[attribute] = social_link["href"] if social_link["href"].include?(attribute.to_s)
      end 
    end
    profile_hash
  end

end

