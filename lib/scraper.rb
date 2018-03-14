require 'nokogiri'
require 'open-uri'
require 'pry'

#doc.css(".student-card")
#doc.css(".student-name").text
#doc.css(".student-location").text
#doc.css(".student-card a").map { |link| link['href']}

#doc.css(".social-icon-container").css('a').attr('href').value
#doc.css(".social-icon-container").css('a').map { |link| link['href'] }
#doc.css('.profile-quote').text
#doc.css('.bio-content').css('p').text

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css(".student-card").each do |student_card|
      student = {}
      student[:name] = student_card.css(".student-name").text
      student[:location] = student_card.css(".student-location").text
      student[:profile_url] = student_card.css('a').attr('href').value
      student_array << student
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    social = doc.css(".social-icon-container").css('a').map { |link| link['href'] }
    profile_hash = {}
    social.each do |link|
      if link.include?('twitter.com')
        profile_hash[:twitter] = link
      elsif link.include?('linkedin.com')
        profile_hash[:linkedin] = link
      elsif link.include?('github.com')
        profile_hash[:github] = link
      else
        profile_hash[:blog] = link
      end
    end
    profile_hash[:profile_quote] = doc.css('.profile-quote').text
    profile_hash[:bio] = doc.css('.bio-content').css('p').text
    profile_hash
  end

end
