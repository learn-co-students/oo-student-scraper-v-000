require 'open-uri'
require 'pry'
require 'nokogiri'

index_url = "fixtures/student-site/index.html"


class Scraper

  attr_accessor :scraped_students

  def self.scrape_index_page(index_url)
    scraped_students = []
    html = Nokogiri::HTML(open(index_url))
    html.css("div.student-card").each do |card|
      student = {
      :name => card.css(".student-name").text,
      :location => card.css(".student-location").text,
      :profile_url => card.css("a").attribute("href").value
    }
    scraped_students << student
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    html.children
      scraped_student = {
      :linkedin=>"https://www.linkedin.com/in/flatironschool",
      :github=>"https://github.com/learn-co,
      :blog=>"http://flatironschool.com",
      :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      :bio=> "I'm a school"
      }
      # binding.pry

  end
end
