require 'open-uri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = Array.new
    index_page.css("div.roster-cards-containter").each do |card|
      card.css(".student-card a").each do |student|
        profile_url = "http://127.0.0.1:4000/#{student.attr('href')}"
        location = student.css('.student-location').text
        name = student.css('.student-name').text
      end
    end
    # :name, :location, :profile_url
  end

  def self.scrape_profile_page(profile_url)
  end
end
