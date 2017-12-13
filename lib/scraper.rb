require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :scraped_students
  @scraped_students = []

  def self.scrape_index_page(index_url)
    html = open('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    students = doc.css("div.student-card")
    students.each do | student |
      student_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a.attribute(href)").text
      }
      @scraped_students << student_hash
    end
    @scraped_students
  end

  def self.scrape_profile_page(profile_url)

  end

end
