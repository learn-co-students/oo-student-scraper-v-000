require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    index = []
    doc.css('.student-card').each do |card|
      index << { name: card.css('.student-name').text,
        location: card.css('.student-location').text,
        profile_url: card.css('a')[0]['href'] }
    end
    index
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    known_links = ['//twitter.com', '//www.linkedin.com', '//github.com/']
    profile = {}
    doc.css('.social-icon-container a').each do |link|
      profile[:twitter] = link['href'] if link['href'].include?('//twitter.com')
      profile[:linkedin] = link['href'] if link['href'].include?('//www.linkedin.com')
      profile[:github] = link['href'] if link['href'].include?('//github.com/')
      profile[:blog] = link['href'] unless known_links.any?{|word| link['href'].include?(word)}
    end
    profile[:profile_quote] = doc.css('.profile-quote').text
    profile[:bio] = doc.css('.bio-content .description-holder p').text
    profile
  end

end
