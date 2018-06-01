require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open("fixtures/student-site/index.html"))
    doc.css(".roster-cards-container").each do |key, value|
      student-name = doc.css(".roster-cards-container").first.css(".student-name").first.text
      student-location = doc.css(".roster-cards-container").first.css(".student-location").first.text
      card =  index_url.css(".student-card a").first
      link = card.attr("href")

      puts "{:name => #{student-name}, :location => #{student-location}, :profile-url => #{link} }"
   #index_url = doc.css(".roster-cards-container").first

    end
  end

  def self.scrape_profile_page(profile_url)

  end

end
