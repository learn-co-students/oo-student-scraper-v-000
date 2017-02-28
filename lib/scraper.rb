require 'open-uri'
require 'pry'
# require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css('.student-card').each do |card|
      student = {}
      student[:name] = card.css('.card-text-container .student-name').text
      student[:location] = card.css('.card-text-container .student-location').text
      student[:profile_url] = "./fixtures/student-site/" + card.css('a').first.attr('href')
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    links = doc.css('.social-icon-container a').map {|link| link['href']}
    profile = {}
    links.each do |link|
      if link.include? "twitter"
        profile[:twitter] = link
      elsif link.include? "linkedin"
        profile[:linkedin] = link
      elsif link.include? "github"
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end
    profile[:profile_quote] = doc.css('.vitals-text-container .profile-quote').text
    profile[:bio] = doc.css('.details-container .bio-block .bio-content .description-holder p').text
    profile
  end

end
