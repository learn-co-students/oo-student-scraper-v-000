require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
  
    index.css('div.student-card').each do |student|
      student = {
        :name => student.css('h4.student-name').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').attribute('href').value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(open(profile_url))
    profile = {}
    social_link = html.css('.social-icon-container a').map {|element| element.attribute('href').value}
    
    social_link.each do |href|
      if href.include?('twitter')
        profile[:twitter] = href
      elsif href.include?('linkedin')
        profile[:linkedin] = href
      elsif href.include?('github')
        profile[:github] = href
      else
        profile[:blog] = href
      end
    end
    
    profile[:profile_quote] = html.css('div.profile-quote').text
    profile[:bio] = html.css('div.description-holder p').text
    
    profile
    
  end

end

