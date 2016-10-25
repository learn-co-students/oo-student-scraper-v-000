require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
  	result = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css('.student-card').each do |student|
	  	student_hash = {}
      student_hash[:name] = student.css('.student-name').text
      student_hash[:location] = student.css('.student-location').text
      student_hash[:profile_url] = "./fixtures/student-site/#{student.css('a')[0]['href']}"
      result << student_hash
    end
    result
  end

  def self.scrape_profile_page(profile_url)
    result = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css('.social-icon-container a').each do |item|
      if item.css('img')[0]['src'].include?('rss-icon')
      	result[:blog] = item['href']
      elsif item['href'].include?('twitter')
      	result[:twitter] = item['href']
      elsif item['href'].include?('linkedin')
      	result[:linkedin] = item['href']
      elsif item['href'].include?('github')
      	result[:github] = item['href']
      end
    end

    result[:profile_quote] = doc.css('.profile-quote').text
    result[:bio] = doc.css('.description-holder > p').text
    result
  end


end

