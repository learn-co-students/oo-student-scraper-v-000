require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :index_url, :profile_url

  def self.scrape_index_page(index_url)
    binding.pry
    #responsible for scraping the index page that lists all of the students. This gets a list of all the profiles
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
      students << {
        :name => students.css("h4").children.each {|child| puts child},
        :location => students.css("p.student-location").children.each {|child| puts child},
        :profile_url => stud.css("div.roster-cards-container").each {|card| card.css(".student-card a").each {|student| puts student.attr("href")}}
      }

  
  end



  def self.scrape_profile_page(profile_url)
    #this scrapes the individual profiles

    doc= Nokogiri::HTML(open(profile_url))
    profiles = []

    
  end

  end
end

