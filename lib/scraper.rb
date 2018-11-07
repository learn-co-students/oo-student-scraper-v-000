require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url



  def self.scrape_index_page(index_url)
      students = []
      html = open(index_url)
      index = Nokogiri::HTML(html)
      student_card = index.css(".student-card")
      student_name = student_card.css(".student-name").text
      student_location = student_card.css(".student-location").text
      binding.pry
  end



  def self.scrape_profile_page(profile_url)

  end

end
