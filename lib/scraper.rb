require 'open-uri'
require 'nokogiri'
require 'pry'
require 'jekyll'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    page = Nokogiri::HTML(html)

    scraped_students = Array.new

    page.css('div.roster-cards-container').each do |person|
      person.css('.student-card').each do |card|

      scraped_students << {:name => card.css('.student-name').text,\
        :location => card.css('p.student-location').text,\
        :profile_url => "#{index_url}#{card.css('a').attr('href').value}"
      }
      end
    end
    scraped_students
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    attributes = {}
    links= []

    profile.css('.social-icon-container a').each do |link|
      links << link.attr('href')
    end

    links.each do |url|
      if url.include?("twitter")
        attributes[:twitter] = url
      elsif url.include?("linkedin")
        attributes[:linkedin] = url
      elsif url.include?("github")
        attributes[:github] = url
      else
        attributes[:blog] = url
      end
    end

    attributes[:profile_quote] = profile.css('.profile-quote').text
    attributes[:bio] = profile.css('.description-holder p').text  

    attributes
  end  


end















