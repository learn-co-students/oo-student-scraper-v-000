require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
# @@all = []

  def self.scrape_index_page(index_url)
    learn = Nokogiri::HTML(open(index_url))
    learn.css("div.student-card a").each do |card|
      name = card.css("h4").text
      location = card.css("p").text
      profile_url = card.attr("href")
      student_hash = {name: name, location: location, profile_url: profile_url}
      @@all << student_hash
    end
      @@all
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    learn = Nokogiri::HTML(open(index_url))

  end

end
