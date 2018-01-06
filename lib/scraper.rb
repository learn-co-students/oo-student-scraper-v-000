require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url

def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open(index_url))
  students = []

  doc.css("div.roster-cards-container").each do |student_value|
  student = {}

  #binding.pry
  student = {
  @name => student_value.css("div.student-card")[0].search("h4.student-name").text,
  @location => student_value.css("div.student-card")[0].search("p.student-location").text,
  @profile_url => student_value.css("div.student-card")[0].search("a href")
  }

  students<<student
  end
  students
end

  def self.scrape_profile_page(profile_url)

  end

  #def self.scrape_index_page(index_url)
    #doc = Nokogiri::HTML(open(index_url))
    #students = []

    #doc.css("div.roster-cards-container").each do |student_value|
    #student = {}

    #binding.pry
    #student = {
    #student[:name] => student_value.css("div.student-card").each.search("h4.student-name").text,
    #student[:location] => student_value.css("div.student-card").each.search("p.student-location").text,
    #student[:profile_url] => student_value.css("div.student-card").each.search("a href")
    #}
#
    #students<<students
    #end
    #students
  #end
end
