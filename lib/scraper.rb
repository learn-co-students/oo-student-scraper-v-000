require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_info = html.css("div.roster-cards-container").css(".student-card a")

    student_info.map do |info|
      {:name => info.css("div.card-text-container h4").text, :location => info.css("div.card-text-container p").text, :profile_url => info['href']}
    end

  end

  def self.scrape_profile_page(profile_url)

  end

end
