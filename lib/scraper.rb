require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css("div .roster-cards-container")
    students.each do |student_card|
     binding.pry
    end



  end

  def self.scrape_profile_page(profile_url)

  end

end
