require 'open-uri'
require 'pry'
require 'open-uri'

class Scraper

  def self.scrape_index_page(html)
    index = Nokogiri::HTML(open(html))
    students = []
    student.css("div.roster-cards-container").each do |profile|
    title = student.css("student-card a").text = {
      :student_link => student.css("div.project-thumbnail a img").attribute("src").value,
      :name => student.css("p.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
    
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

