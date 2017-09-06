require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  # binding.pry
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # div class = "roster-cards-container"
    doc.css(("div.roster-cards-container")
    student_name = name.css(".student_name").text
    student_location = location.css(".student_location").text
    profile_url = "#{student.attr('href')}"


    binding.pry


  end

  def self.scrape_profile_page(profile_url)

  end

end
