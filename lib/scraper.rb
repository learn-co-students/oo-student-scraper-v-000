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

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social = {}
    doc.css('.social-icon-container').css('a').map do |student|
        social[:linkedin] = student.attr('href') if student.attr('href').include?('linkedin')
        social[:twitter] = student.attr('href') if student.attr('href').include?('twitter')
        social[:github] = student.attr('href') if student.attr('href').include?("github")
        social[:blog] = student.attr('href')
    end
        social[:profile_quote] = doc.css('.vitals-text-container').css('.profile-quote').text.gsub("\"", "")
        social[:bio] = doc.css('.description-holder').css('p').text.gsub("\"", "")
    # binding.pry
    social
  end

end

# Scraper.new.scrape_profile_page("http://students.learn.co/students/joe-burgess.html")
