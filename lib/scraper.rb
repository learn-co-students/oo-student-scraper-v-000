require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = open(index_url)
    names = []
    locations = []
    scraped_students = []
    doc = Nokogiri::HTML(index)
    student_data = doc.css(".student-card")

    student_data.each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

