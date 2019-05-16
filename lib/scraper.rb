require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    students = doc.css('.student-card')
    student_array = []
    students.each do |student|
      student_hash = {
        :name => student.css('h4.student-name').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').attribute("href").value
      }
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    social_media_hash = {}
    social_links = doc.css('.social-icon-container a').collect{|link|
      link.attribute('href').value}

    social_links.each do |link|
      if link.match('twitter')
        social_media_hash[:twitter] = link
      elsif link.match('linkedin')
        social_media_hash[:linkedin] = link
      elsif link.match('github')
        social_media_hash[:github] = link
      else
        social_media_hash[:blog] = link
      end
    end

      social_media_hash[:profile_quote] = doc.css('div.profile-quote').text
      social_media_hash[:bio] = doc.css('div.bio-block.details-block p').text

      social_media_hash
    end

end
