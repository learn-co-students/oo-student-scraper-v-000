require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = index_url
    index = Nokogiri::HTML(html)
   
    students = []
    
    #name:index.css('div.card-text-container h4.student-name').text
    #location:index.css('div.card-text-container p.student-location').text
    #html:index.css('div.student-card a').attribute('href').value
    
    index.css('div.roster-cards-container').each do |student|
      student = {
        :name => index.css('div.card-text-container h4.student-name').text,
        :location => index.css('div.card-text-container p.student-location').text,
        :profile_url => index.css('div.student-card a').attribute('href').value
      }
      students << student
    end
    
    students
  
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

