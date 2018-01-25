require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Array.new
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css('.student-card').each do |student|
      info = Hash.new
      info[:name] = student.css('.student-name').text
      info[:location] = student.css('.student-location').text
      info[:profile_url] = student.css('a').attribute('href').text
      students << info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = Hash.new
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    doc.css('.social-icon-container a').each do |link|
      if link.attribute("href").text.include?('linkedin')
        student[:linkedin] = link.attribute("href").text
      elsif link.attribute("href").text.include?('github')
        student[:github] = link.attribute("href").text
      elsif link.attribute("href").text.include?('twitter')
        student[:twitter] = link.attribute("href").text
      else
        student[:blog] = link.attribute("href").text
      end
      student[:profile_quote] = doc.css('.vitals-text-container div').text
      student[:bio] = doc.css('.details-container p').text
    end
    student
  end
end
