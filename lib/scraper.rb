require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)
    students = []
    page.css(".student-card").each do |student_card|
    #binding.pry
      student = {
        :name => student_card.css("h4").text,
        :location => student_card.css("p.student-location").text,
        :profile_url => student_card.css("a").attribute('href').value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    
    
  end

end

