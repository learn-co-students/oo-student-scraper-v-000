require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    
    page.css('div.student-card').each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").first['href']
      }
    end
     
    students
  
  end
  #scrape_index_page('./fixtures/student-site/index.html')

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    attributes_hash = {}
    
    links = page.css('.social-icon-container a').collect {|link| link.attr('href')}
    links.each do |link|
      link.include?('twitter')? attributes_hash[:twitter] = link : ""
      link.include?('github')? attributes_hash[:github] = link : ""
      link.include?('linkedin')? attributes_hash[:linkedin] = link : ""
      !link.include?('twitter') && !link.include?('github') && !link.include?('linkedin')? attributes_hash[:blog] = link : ""
    end 
    
      attributes_hash[:profile_quote] = page.css('.profile-quote').text
      attributes_hash[:bio] = page.css('.description-holder p').text
      attributes_hash
  
  end
 # scrape_profile_page('./fixtures/student-site/students/joe-burgess.html')
end

