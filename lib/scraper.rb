require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML.parse(html)
    index_page = doc.css(".student-card a")
    array = []
    index_page.each do |card|
      student = Hash.new
      student[:name] = card.css("div.card-text-container h4").text
      student[:location] = card.css("p").text
      student[:profile_url] = card['href']
      array.push(student)
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML.parse(html)
    profile_page = doc.css(".main-wrapper-profile")
    array = []
    profile_page.each do
  end

end

Scraper.scrape_index_page("http://67.205.188.72:60933/fixtures/student-site/")