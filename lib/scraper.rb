require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
  
    doc.css('div.roster-cards-container').each do |card|
      students =
      card.css('.student-card a').map do |student|
        {
          :name => student.css('.student-name').text,
          :location => student.css('.student-location').text,
          :profile_url => "./fixtures/student-site/#{student.attr('href')}"
        } 
      end
     end
      students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    attributes = Hash.new

    doc.css('.social-icon-container a').each do |social|
      attributes[:twitter] = social['href'] if social['href'].include?('twitter') 
      attributes[:linkedin] = social['href'] if social['href'].include?('linkedin') 
      attributes[:github] = social['href'] if social['href'].include?('github') 
      attributes[:blog] = social['href'] if 
        (doc.css('.social-icon-container img').map do |image|
          image['src'].include?('rss-icon')
        end).include?(true) 
    end
      attributes[:bio] = doc.css('.details-container .description-holder p').text
      attributes[:profile_quote] = doc.css('.profile-quote').text
      attributes
  end
end
