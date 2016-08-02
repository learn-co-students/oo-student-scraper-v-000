require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    url = Nokogiri::HTML(open(index_url))

    students = []

    url.css("div.student-card").each do |student_card|
      student = {
      :name => student_card.css("h4.student-name").text,
      :location => student_card.css("p.student-location").text,
      :profile_url =>student_card.css("a").attribute("href").value
      }
      students << student
    end
    return students
  end


  def self.scrape_profile_page(profile_url)

  end

end
