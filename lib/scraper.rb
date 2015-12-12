require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    index_url = index_url += "/" unless index_url[-1,1] == "/"
   
    student_cards = []
    doc.css('.student-card').each do |post|
        student_hash = {}
      student_hash[:name] = post.css('.student-name').text
      student_hash[:location] = post.css('.student-location').text
      student_hash[:profile_url] = index_url + post.css('a').attr('href').value
        student_cards << student_hash
    end 
     
      student_cards
  end

  # def scrape_profile_page(profile_url)
  #   doc = Nokogiri::HTML(open(profile_url))
  #   # binding.pry
  #   doc
  # end

end

# Scraper.new.scrape_index_page("http://students.learn.co")
