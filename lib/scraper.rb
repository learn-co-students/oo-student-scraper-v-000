require 'open-uri'
require 'pry'
require 'nokogiri'

index_url = "fixtures/student-site/index.html"
@@scraped_students = []

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    html.css("div.student-card").each do |card|
      student = {
      :name => html.css(".student-name").text,
      :location => html.css(".student-location").text,
      :profile_url => html.css("div.student-card a").attribute("href").text
    }
    @@scraped_students << student
    # binding.pry
    end
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
  end
binding.pry
end
