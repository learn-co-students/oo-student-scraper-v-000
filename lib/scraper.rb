require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    res = []
    doc.css('.student-card').each do |card|
      res << { name: card.css('.student-name').text,
        location: card.css('.student-location').text,
        profile_url: card.css('a')[0]['href'] }
    end
    res
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    known_links = ['//twitter.com', '//www.linkedin.com', '//github.com/']
    res = {}
    doc.css('.social-icon-container a').each do |link|
      res[:twitter] = link['href'] if link['href'].include?('//twitter.com')
      res[:linkedin] = link['href'] if link['href'].include?('//www.linkedin.com')
      res[:github] = link['href'] if link['href'].include?('//github.com/')
      res[:blog] = link['href'] unless known_links.any?{|word| link['href'].include?(word)}
    end
    res[:profile_quote] = doc.css('.profile-quote').text
    res[:bio] = doc.css('.bio-content .description-holder p').text
    res
  end
end
