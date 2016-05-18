require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    student_doc = Nokogiri::HTML(html)
    
    students = []

    student_doc.css("div.student-card").each do |student|

      student_rel_link = student.css("a").attribute("href").value

      student = {
        :name=>student.css("a div.card-text-container h4.student-name").text,
        :location=>student.css("a div.card-text-container p.student-location").text,
        
        :profile_url=>URI.join(index_url, student_rel_link).to_s
        
      }
      

      students << student
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

#Scraper.scrape_index_page("http://127.0.0.1:4000")

