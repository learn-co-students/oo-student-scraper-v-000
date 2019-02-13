require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

    doc.css('div.student-card').each do |student|
      name = student.css('h4.student-name').text
      location = student.css('p.student-location').text
      profile_url = student.css('a').attribute('href').value

      student_card = {name: name, location: location, profile_url: profile_url}

      scraped_students << student_card
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student_profiles = {}

    social_icons = doc.css('div.social-icon-container').each do |info|
      info = info.css('.social-icon-container a').attribute('href').value

      if info.include?('linkedin')
        linkedin: info
      elsif info.include?('github')
        github: info
      elsif info.include?('blog')
        blog: info
      end

      profile_quote = 
    end
    # binding.pry

    # linkedin:
    # github:
    # blog:
    # profile_quote:
    # bio:


  end

end
