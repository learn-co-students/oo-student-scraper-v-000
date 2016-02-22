require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    binding.pry
    # 
    students = []
    doc.css("div.student-card").each do |student|
      students << {
        :name => student.css("a div.card-text-container h4.student-name").text,
        :location => student.css("a div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    students
    
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_data = {}
    doc.css() do |attribute|
      student_data[attribute.css().to_sym] = attribute.css()
    end
    student_data
  end

end

Scraper.scrape_index_page("http://127.0.0.1:4000/")
