require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
      doc.css(".student-card").each do |card|
      students << {name: card.css("h4.student-name").text, :location => card.css("p.student-location").text, profile_url: card.css("a").attribute("href").value}
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    media = []
    doc.css("div.social-icon-container").each do |icon|
      icon.css("a href").attribute.text
binding.pry
      media << {}



  end

end
