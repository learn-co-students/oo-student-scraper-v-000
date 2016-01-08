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
    student = {}
    social_links = []
    
    # Grabs links in the .social-icon container div and adds their href
    # attribute value to an array of social_links
    self.get_page(profile_url).css('.social-icon-container a').each do |s|
      social_links << s.attribute('href').value
    end
    
    # iterates over social links and assigns them to the appropriate
    # key-value pairs in the student hash
    social_links.each do |s|
      if s.match(/twitter\.com/)
        student[:twitter] = s
      elsif s.match(/linkedin\.com/)
        student[:linkedin] = s
      elsif s.match(/github\.com/)
        student[:github] = s
      else
        student[:blog] = s
      end
    end
    
    student[:profile_quote] = self.get_page(profile_url).css('.profile-quote').text
    student[:bio] = self.get_page(profile_url).css('.bio-content p').text
    
    student
  end

end
