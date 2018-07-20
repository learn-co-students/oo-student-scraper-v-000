require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    #doc.css("div.student-card").each do |student|
    #doc.css("a href").value

    #end
      students = {}
      #:name => student.css("h4.student-name").text,

      #:location => student.css("p.student-location").text,



    #doc.css("div.student-card a").attribute("href").value
    #locations = doc.css("p.student-location").first.text

    doc.css("div.student-card")
    binding.pry
  end
  #names = doc.css("h4.student-name").text
  def self.scrape_profile_page(profile_url)

  end

end
