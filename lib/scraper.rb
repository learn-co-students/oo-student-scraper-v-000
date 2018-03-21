require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper


  def self.scrape_index_page(index_url)
    # student_hash = {}
    arr = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    iteration = doc.css('.student-card')

    iteration.each do |student|
      student_hash = {}
      student_hash[:name] = student.css('.student-name').text
      student_hash[:location] = student.css('.student-location').text
      student_hash[:profile_url] = student.css('a')[0]['href']
      arr.push(student_hash)
    end

    arr
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    iteration = doc.css('.social-icon-container')
    socialLinks = doc.css('.social-icon-container a')
    links = []
    socialLinks.each do |link|
      links << link['href'].to_str
    end
    links.each do |link|
      if link.include? "twitter"
        hash[:twitter] = link
      elsif link.include? "linkedin"
        hash[:linkedin] = link
      elsif link.include? "github"
        hash[:github] = link
      else
        hash[:blog] = link
      end
    end
    hash[:profile_quote] = doc.css('.profile-quote').text
    hash[:bio] = doc.css('.details-container p').text
    hash
  end

end
