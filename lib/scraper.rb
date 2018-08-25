require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    #binding.pry
    array = []

    doc.css(".student-card").each do |student|
      array << {
        :name => student.css(".student-card").css("h4").text,
        :location => student.css(".student-card").css("p").text,
        #:profile_url => student.css(".student-card a").attribute("href").value,
      }
    end
    array

  end

  def self.scrape_profile_page(profile_url)

  end

end

#student name: doc.css(".student-card").css("h4").text
#location: doc.css(".student-card").css("p").text
#student_url: doc.css(".student-card").css("a").attribute("href").value
