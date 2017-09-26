require 'open-uri'
require 'pry'
require 'nokogiri'


class Scraper

  def self.scrape_index_page(index_url)
    website = Nokogiri::HTML(open(index_url))
    students = []
    website.css(".student-card").each do |student|
      new_student = {
        :name => student.css(".card-class-container h4.student-name").text,
        :location => student.css(".card-class-container p.student-location").text,
        :profile_url => student.css("")



      }



  end





  def self.scrape_profile_page(profile_url)

  end

end
