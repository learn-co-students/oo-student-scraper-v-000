require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    doc.css("div.student-card").collect do |student|
      {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => "http://127.0.0.1:4000/" + student.css("a").attribute("href").value
      }
    end
  end

  def self.scrape_profile_page(profile_url)
    student = Nokogiri::HTML(open(profile_url))



  end

end
