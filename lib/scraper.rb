require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css('div.student-card').each do |card|
    name = card.css('.student-name').text
    profile_url = index_url + '/' + card.css('a').attribute('href').value
    location =  card.css('p.student-location').text
    student = {name: name, location: location, profile_url: profile_url}
    students << student 
    end 
    students
#   binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# Scraper.scrape_index_page("http://localhost:4000")