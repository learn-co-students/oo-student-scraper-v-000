require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Array.new
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css('.student-card').each do |student|
      student_info = Hash.new
      data = student.css('a')
      student_info[:name] = student.css('.student-name').text
      student_path = student.css("a")[0]["href"]
      student_info[:location] = student.css('.student-location').text
      student_info[:profile_url] = index_url + student_path
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = Hash.new
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    doc.css('.social-icon-container a').each do |social_network|
      link = social_network["href"]
      case link
      when /\btwitter\b/
        scraped_student[:twitter] = link
      when /\blinkedin\b/
        scraped_student[:linkedin] = link
      when /\bgithub\b/
        scraped_student[:github] = link
      else
        scraped_student[:blog] = link
      end
    end
    scraped_student[:profile_quote] = doc.css('.profile-quote').text
    scraped_student[:bio] = doc.css('.description-holder p').text
    scraped_student
  end

end

