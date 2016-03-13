require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css('.roster-cards-container .student-card')
    student_info =  []
    students.each do |student|
      student_info << {name: student.css('h4').text, location: student.css('p').text, profile_url: "#{index_url}#{student.css('a')[0]['href']}"}
    end
    student_info
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_links = doc.css('div .vitals-container .social-icon-container')
    student_profile = {}
    student_links.css('a').each do |student_link|
      if student_link['href'].include?('twitter')
        student_profile[:twitter] = student_link['href']
      elsif student_link['href'].include?('linkedin')
        student_profile[:linkedin] = student_link['href']
      elsif student_link['href'].include?('github')
        student_profile[:github] = student_link['href']
      else
        student_profile[:blog] = student_link['href']
      end
    end
    student_profile[:profile_quote] = doc.css('div .vitals-container .vitals-text-container div').text
    student_profile[:bio] = doc.css('div .details-container p').text
    student_profile
  end

end

