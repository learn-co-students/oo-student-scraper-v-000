require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    student_hash = []
    html.css("div.roster-cards-container").each do |student|
      student.css(".student-card a").each do |stud|
        profile_url = "#{stud.attr("href")}"    
        name = stud.css(".student-name").text
        location = stud.css(".student-location").text
        # binding.pry
        student = {:name => name, :location => location, :profile_url => profile_url}
        student_hash << student
      end
    end
      student_hash
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    
  end

end

