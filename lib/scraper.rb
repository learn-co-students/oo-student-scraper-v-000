require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    
    html = File.read(index_url)
    roster = Nokogiri::HTML(html)
    students = []
    roster.css(".student-card").each do |student_card|
    
    # student = student_card.css(".student-name").text
      # binding.pry
    students << [
      :name => student_card.css(".student-name").text,
      :location => student_card.css(".student-location").text,
      :profile_url => student_card.css("a").attribute("href").value
    ]
    
    end
    
    students
    
  end

  def self.scrape_profile_page(profile_url)
    
  end
  
  self.scrape_index_page("./fixtures/student-site/index.html")

end

