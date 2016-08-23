require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    student_site = Nokogiri::HTML(html)
    scraped_students = []
    student_site.css("div.student-card").each do |s|
      scraped_students << {
      :name => s.css("h4.student-name").text,
      :location => s.css("p.student-location").text,
      #Had to use string interpolation to get this working because the spec wants the URL to be
      #relative to the html in /fixtures
      :profile_url => "./fixtures/student-site/#{s.css("a").first['href']}"
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    student_site = Nokogiri::HTML(html)
    student_info = {}
    student_info.css("div.social-icon-container a").each do |l|
      student_info << {
        
      }

  end

end
