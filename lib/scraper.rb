require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    binding.pry

    names = doc.css('h4.student-name')
    # names.each { |n| puts "#{n.text}" }
    locations =  doc.css('.student-location')
    urls =  doc.css('.student-card a').attr('href')
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
  end

end
