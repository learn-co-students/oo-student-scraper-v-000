require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.get_page(index_url)
    html = open(index_url)
    Nokogiri::HTML(html)
  end
  
  def self.scrape_index_page(index_url)
    students = []
    self.get_page(index_url).css('.student-card').each do |s|
      student = {}
      student[:name] = s.css('.card-text-container h4.student-name').text
      student[:location] = s.css('.card-text-container p.student-location').text
      student[:profile_url] = index_url + '/' + s.css('a').attribute('href').value
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

