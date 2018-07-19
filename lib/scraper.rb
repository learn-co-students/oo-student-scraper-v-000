require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))
    student_info = page.css(".student-card")
    student_info.each do |student_cards|
      students << {
        :name => student_cards.css("h4.student-name").text,
        :location => student_cards.css("p.student-location").text,
        :profile_url => student_cards.css(".student-card a[href]")
      }
    end
    students
  end


  def self.scrape_profile_page(profile_url)

  end

end
