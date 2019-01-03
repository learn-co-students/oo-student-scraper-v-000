require 'open-uri'
require 'pry'
require 'nokogiri'
require 'rest-client'

class Scraper

  def self.scrape_index_page(index_url)
    html = RestClient.get(index_url)
    doc = Nokogiri::HTML.parse(html)
    index_page = doc.css(".card-text-container")
    index_page_urls = doc.css(".student-card a")
    array = []
    index_page.each do |card|
      student = Hash.new
      student[:name] = card.css("h4").text
      student[:location] = card.css("p").text
      array.push(student)
    end
    index_page_urls.each do |card|
      url = card['href']
      array.each do |student|
        student[:profile_url] = url
      end
    end
    puts array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

Scraper.scrape_index_page("http://67.205.188.72:60933/fixtures/student-site/")