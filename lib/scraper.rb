require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper
  #http://www.nokogiri.org/tutorials/parsing_an_html_xml_document.html <- remember this!
  #http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html <- Searching HTML Document

  def self.scrape_index_page(index_url)
    students = []
    Nokogiri::HTML(open(index_url)).css('.student-card').each {|student| students << {name: student.css('.student-name').text, location: student.css('.student-location').text, profile_url: "#{index_url}#{student.css('a')[0]['href']}" }}
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    details = {}
    doc.css('.social-icon-container a').each do |link|
      if link['href'].include?('twitter')
        details[:twitter] = link['href']
      elsif link['href'].include?('linkedin')
        details[:linkedin] = link['href']
      elsif link['href'].include?('github')
        details[:github] = link['href']
      else
        details[:blog] = link['href']
      end
    end
    details[:profile_quote] = doc.css('.profile-quote').text.strip
    details[:bio] = doc.css('.description-holder p').text.strip
    details
  end

end

