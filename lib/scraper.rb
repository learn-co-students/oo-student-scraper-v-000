require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students_array = []

    students = doc.css('.student-card')

    students.each do |student|
      students_array << {
        :name => student.css('h4.student-name').text,
        :location => student.css('p.student-location').text,
        :profile_url => student.css('a').attribute('href').value
      }
    end

    students_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    attribute_hash = {}
    attribute_hash[:profile_quote] = doc.css('div.profile-quote').text
    attribute_hash[:bio] = doc.css('div.bio-content.content-holder div.description-holder p').text

    social_links = doc.css('div.social-icon-container a')
    social_links.each do |link|
      link_url = link.attribute('href').value

      if link_url.include?('github')
        attribute_hash[:github] = link_url
      elsif link_url.include?('linkedin')
        attribute_hash[:linkedin] = link_url
      elsif link_url.include?('twitter')
        attribute_hash[:twitter] = link_url
      elsif link.css('img').attribute('src').value.include?('rss')
        attribute_hash[:blog] = link_url
      end
    end

    attribute_hash
  end

end
