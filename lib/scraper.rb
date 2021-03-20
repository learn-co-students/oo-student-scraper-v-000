require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  attr_accessor :Student

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    #studnets = page.css("div.student-card")
    # iterate through students to find
    #page.css("div.student-card").first =>Ryans card
    # page.css("div.card-text-container h4").first.text => Ryan's name
    #page.css("div.card-text-container p").first.text => Ryan's location
    #page.css("div.student-card a").first.attribute("href").value

    # binding.pry
    students = []
    page.css("div.student-card").each do |student|

      students << {
        :name => student.css("div.card-text-container h4").text,
        :location => student.css("div.card-text-container p").text,
        :profile_url => student.css("div.student-card a")[student].attribute("href")
        # binding.pry
      }

    end
      binding.pry
  end

  def self.scrape_profile_page(profile_url)

  end

end
