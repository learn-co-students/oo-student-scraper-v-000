require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_hashes = Array.new
    doc.css('div.student-card').each do |student|
      student_hashes << {
      name: student.css('h4.student-name').text,
      location: student.css('p.student-location').text,
      profile_url: index_url + student.css('a').attribute('href').value
      }
    end
    student_hashes
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_attributes = Hash.new
    doc.css('div.social-icon-container > a').each do |a|
      link = a.attribute('href').value
      if link.include?('github')
        student_attributes[:github] = link
      elsif link.include?('twitter')
        student_attributes[:twitter] = link
      elsif link.include?('linkedin')
        student_attributes[:linkedin] = link
      else
        student_attributes[:blog] = link
      end
    end
    student_attributes[:profile_quote] = doc.css('div.profile-quote').text
    student_attributes[:bio] = doc.css('div.description-holder > p').text
    student_attributes
  end

end
