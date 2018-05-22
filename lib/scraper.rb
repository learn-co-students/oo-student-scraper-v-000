require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    profiles = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('div.student-card')
    students.each {|s|
    profiles << {:name => s.css('h4').text, :location => s.css('p').text, :profile_url => s.css('a')[0]['href']}}
    profiles
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = doc.css('div.social-icon-container')
    #linkedin
    #github
    #blog
    #profile_quote
    #bio
    binding.pry
  end

end

#roster-cards-container

