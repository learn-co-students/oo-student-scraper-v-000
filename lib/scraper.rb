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
    profile_quote = doc.css(".profile-quote").text
    profile_bio = doc.css(".description-holder p").text
    student = Hash.new
    doc.css('.social-icon-container a').each do |link|
      if link['href'].include?("twitter")
        student[:twitter] = link['href']
      elsif link['href'].include?("linkedin")
        student[:linkedin] = link['href']
      elsif link['href'].include?("github")
        student[:github] = link['href']
      else
        student[:blog] = link['href']
      end
    end
    student[:profile_quote] = profile_quote
    student[:bio] = profile_bio
    student
  end

end

Scraper.scrape_profile_page("http://67.205.188.72:57630/fixtures/student-site/students/eric-chu.html")