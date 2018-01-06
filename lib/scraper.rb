require 'open-uri'
require 'pry'

class Scraper

attr_accessor :name, :location, :profile_url

def self.scrape_index_page(index_url)
  doc = Nokogiri::HTML(open(index_url))
  students = [{}]
  doc.css("div.roster-cards-container").each do |student_value|
  student = {}
    student_value.css("div.student-card").each do |student_attr|
      student = {
      :name => student_attr.search("h4.student-name").text,
      :location => student_attr.search("p.student-location").text,
      :profile_url => student_attr.search("a").attribute("href").value
      }
      students<<student
    end
  students
  end
end

  def self.scrape_profile_page(profile_url)

  end
end
