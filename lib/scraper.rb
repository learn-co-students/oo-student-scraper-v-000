require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []    
    html = Nokogiri::HTML(open(index_url))
    html.css('.student-card').each do |student|
      student_properties = {
      :name => student.css('.student-name').text,
      :location => student.css('.student-location').text,
      :profile_url => student.css('a').collect {|link| link['href']}[0]
      }
      student_array << student_properties
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    student_info = {}
    html = Nokogiri::HTML(open(profile_url))
    html.css('.social-icon-container a').each do |link|
      case 
        when link['href'].include?("twitter") then student_info[:twitter] = link['href']
        when link['href'].include?("linkedin") then student_info[:linkedin] = link['href']
        when link['href'].include?("github") then student_info[:github] = link['href']
        else student_info[:blog] = link['href']
      end
    end
    student_info[:profile_quote] = html.css('.profile-quote').text.strip
    student_info[:bio] = html.css('.bio-content .description-holder').text.strip
    student_info
  end

end

