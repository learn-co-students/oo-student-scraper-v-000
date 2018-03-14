require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('.student-card')
    array = []
    prefix = "./fixtures/student-site/"
    students.each do |student|
      array << {:name => student.css('.student-name').text,:location => student.css('.student-location').text, :profile_url =>prefix+student.css('a')[0]['href']}
    end    
    array    
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = Hash.new
    links = doc.css('.social-icon-container a')
    links.each do |link|
      if link['href'].include?('twitter')
        hash[:twitter] = link['href']
      elsif link['href'].include?('linkedin')        
        hash[:linkedin] = link['href']
      elsif link['href'].include?('github')
        hash[:github] = link['href']
      else
        hash[:blog] = link['href']
      end
    end
    hash[:bio] = doc.css('.details-container .description-holder p').text
    hash[:profile_quote] = doc.css('.profile-quote').text
    #binding.pry
    hash
  end
end
