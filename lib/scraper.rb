require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    student_index_array = {}
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css("div .roster-cards-container")
    students.each do |student_card|
      student_card.css("div a").attribute("href").value
     binding.pry
    end



  end

  def self.scrape_profile_page(profile_url)

  end

end
