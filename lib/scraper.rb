require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css('div.student-card')
    result = []
    students.each do |student|
      result << { 
        :name => student.css('a div.card-text-container h4.student-name').text,
        :location => student.css('a div.card-text-container p.student-location').text,
        :profile_url => student.css('a').attribute('href').value
      }
    end
    result
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped = {
      :profile_quote => doc.css('div.vitals-text-container div.profile-quote').text,
      :bio => doc.css('div.description-holder p').text
    }
    socials = doc.css('div.social-icon-container a')
    socials.each do |social|
      url = social.attribute('href').value
      if url.include?('twitter')
        scraped[:twitter] = url
      elsif url.include?('github')
        scraped[:github] = url
      elsif url.include?('linkedin')
        scraped[:linkedin] = url
      else 
        scraped[:blog] = url
      end 
    end
    scraped
  end

end
