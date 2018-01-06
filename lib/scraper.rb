require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css("div.roster-cards-container").each do |student_value|
    student = {}
    binding.pry
    student[title.to_sym] = {
    student[:name] => student_value.css.("div.student-card").each.search("h4.student-name").text,
    student[:location] => student_value.search("p.student-location").text,
    student[:profile_url] => student_value.search("a href")
    }

    students<<students
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
