require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
  
    doc.css("div.roster-cards-container").each do |card|
      students =
      card.css(".student-card a").map do |student|
        {
          :name => student.css('.student-name').text,
          :location => student.css('.student-location').text,
          :profile_url => "./fixtures/student-site/#{student.attr('href')}"
        } 
      end
     end
      students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

