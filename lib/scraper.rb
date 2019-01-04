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
    profile_page_social_media = doc.css(".social-icon-container a")
    profile_quote = doc.css(".profile-quote").text
    profile_bio = doc.css(".description-holder p").text
    array = []
    student = Hash.new
    profile_page_social_media.each do |card|
      student[:twitter] = card['href']
      student[:linkedin] = card['href']
      student[:github] = card['href']
      student[:blog] = card['href']
    end
    doc.css('.social-icon-container a').each { |link| array.push(link['href'])}
    student[:profile_quote] = profile_quote
    student[:bio] = profile_bio
    student
    puts array[0]
  end

end

Scraper.scrape_profile_page("http://159.203.187.180:41434/fixtures/student-site/students/eric-chu.html")