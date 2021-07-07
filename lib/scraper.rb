require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css('div.student-card').each do |student|
      students << {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").first['href']
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profiles = {}
    
    links = doc.css('.social-icon-container a').collect {|link| link.attr('href')}
    links.each do |link|
      link.include?('twitter')? profiles[:twitter] = link : ""
      link.include?('github')? profiles[:github] = link : ""
      link.include?('linkedin')? profiles[:linkedin] = link : ""
      !link.include?('twitter') && !link.include?('github') && !link.include?('linkedin')? profiles[:blog] = link : ""
    end 
      profiles[:profile_quote] = doc.css('.profile-quote').text
      profiles[:bio] = doc.css('.description-holder p').text
      profiles
    end
end

