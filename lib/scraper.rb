require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    learn_students = Nokogiri::HTML(html)

    profile = {}

    learn_students.css("div.roster-cards-container div.student-card")


  end

  def self.scrape_profile_page(profile_url)

  end

end
