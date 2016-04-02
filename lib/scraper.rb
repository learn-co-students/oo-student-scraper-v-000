require 'open-uri'
require 'nokogiri'
require 'pry'
#require_relative '../fixtures/student-site/index.html'

class Scraper

  def self.scrape_index_page(index_url)
      index_url = "http://127.0.0.1:4000/"
      doc = Nokogiri::HTML(open(index_url))
    #  binding.pry
    #div .student-card
    # => .student-name text
    # =>  .student-location text
    # => .student-card a .attribute('href').value
    doc.css("div .student-card").each do |student_card|
    students_index_array = [{
    :name => doc.css(".student-name").text,
    :location => doc.css(".student-location").text,
    :profile_url => doc.css(".student-card a").attribute("href").value
  },  ]
  students_index_array
end
  end

  def self.scrape_profile_page(profile_url)

  end
#binding.pry
end
