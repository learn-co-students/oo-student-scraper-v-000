require 'open-uri'
require 'pry'
require "nokogiri"

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)
    students = {}
    roster.css(".student-card").each { |student_card|
      #need to figure out attributes for what needs to be in the hash
      student = student_card.css(".student-name").text
      students[student] = {
        :name = student_card.css(".student-name").text,
        :location = student_card.css(".student-location").text
      }
      binding.pry
    }
    
  end

  def self.scrape_profile_page(profile_url)
    
  end
  
  self.scrape_index_page("./fixtures/student-site/index.html")

end

