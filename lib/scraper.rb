require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css('.student-card')
    students_array = []
    student_cards.each do |student|
      students_array << {
        :name => student.css('.student-name').text,
        :location => student.css('.student-location').text,
        :profile_url => student.css('a').attribute('href').value
      }
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_media = doc.css('.social-icon-container').css('a')

    social_media.each do |link|
      if link.attributes['href'].value.include?('twitter')
        student_profile[:twitter] = link.attributes['href'].value
      elsif link.attributes['href'].value.include?('linkedin')
        student_profile[:linkedin] = link.attributes['href'].value
      elsif link.attributes['href'].value.include?('github')
        student_profile[:github] = link.attributes['href'].value
      else
        student_profile[:blog] = link.attributes['href'].value
      end
    end

    student_profile[:profile_quote] = doc.css('.profile-quote').text
    student_profile[:bio] = doc.css('.description-holder').css('p').text
    student_profile
  end
end
