require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css('div.student-card').each do |card|
    name = card.css('.student-name').text
    profile_url = 'http://127.0.0.1:4000' + '/' + card.css('a').attribute('href').value
    location =  card.css('p.student-location').text
    student = {name: name, location: location, profile_url: profile_url}
    students << student 
    end 
    students
#   binding.pry
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    social_media =  profile_page.css('div.social-icon-container a')
    social_media.each do |a| 
      if a.attributes['href'].value.include?('twitter')
        student[:twitter] = a.attributes['href'].value
      elsif a.attributes['href'].value.include?('linkedin')  
        student[:linkedin] = a.attributes['href'].value
      elsif a.attributes['href'].value.include?('github')
        student[:github] = a.attributes['href'].value
      else
        student[:blog] = a.attributes['href'].value
      end 
      student[:profile_quote] = profile_page.css('div.profile-quote').text
      student[:bio] = profile_page.css('div.description-holder p').text
    end 
    student 
  #  binding.pry 
  end

end

Scraper.scrape_profile_page("http://127.0.0.1:4000/students/joe-burgess.html")