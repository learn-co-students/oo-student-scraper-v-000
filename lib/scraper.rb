require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative './student.rb'

class Scraper


  def self.scrape_index_page(index_url)
    blogs = Nokogiri::HTML(open(index_url))

    people = []
    blogs.css('div.roster-cards-container').each do |students|
      students.css(".student-card").each do |profiles|
        student = profiles.css('.student-name').text
        location = profiles.css('.student-location').text
        link =  "./fixtures/student-site/#{profiles.css('a').attr('href').value}"
        people << {name: student, location: location, profile_url: link }
      end
    end
    people
  end

  def self.scrape_profile_page(profile_url)
    personal = Nokogiri::HTML(open(profile_url))
      profile = {}



      personal.css('.social-icon-container').each do |social|
        social.css('a').each do |links|


          if links.attr('href').include?('github')
            profile[:github] = links.attr('href')
          elsif links.attr('href').include?('linkedin')
            profile[:linkedin] = links.attr('href')
          elsif links.attr('href').include?('twitter')
            profile[:twitter] = links.attr('href')
          else
            profile[:blog] = links.attr('href')
          end



        end
      end
      profile[:profile_quote] = personal.css('.profile-quote').text
      profile[:bio] =  personal.css('.bio-content .description-holder p').text
      profile
  end
end
