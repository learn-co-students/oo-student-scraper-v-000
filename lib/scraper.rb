require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

 def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css('.roster-cards-container .student-card')
    student_array = []
    students.each do |student|
      student_array << {name: student.css('h4').text, location: student.css('p').text, profile_url: "#{index_url}#{student.css('a')[0]['href']}"}
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profiles = doc.css('.vitals-container .social-icon-container')
    profile_hash = {}
    profiles.css('a').each do |profile|
      if profile['href'].include?('twitter')
        profile_hash[:twitter] = profile['href']
      elsif profile['href'].include?('linkedin')
        profile_hash[:linkedin] = profile['href']
      elsif profile['href'].include?('github')
        profile_hash[:github] = profile['href']
      else
        profile_hash[:blog] = profile['href']
      end
    end
      profile_hash[:profile_quote] = doc.css('.vitals-container .vitals-text-container .profile-quote').text.strip
      profile_hash[:bio] = doc.css('.description-holder p').text.strip
      profile_hash
  end



end

