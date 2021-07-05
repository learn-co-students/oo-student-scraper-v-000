require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |profiles|
      profiles.css(".student-card a").each do |profile|
        link = "#{profile.attr('href')}"
        location = profile.css('.student-location').text
        name = profile.css('.student-name').text
        students << {name: name, location: location, profile_url: link}
      end
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    student_profile = {}
    profiles = Nokogiri::HTML(open(profile_url))
    links = profiles.css('.social-icon-container').children.css('a').map{|url|url.attribute('href').value}
    links.each do |link|
      if link.include?('linkedin')
        student_profile[:linkedin] = link
      elsif link.include?('github')
        student_profile[:github] = link
      elsif link.include?('twitter')
        student_profile[:twitter] = link
      else
        student_profile[:blog] = link
      end
    end
      student_profile[:profile_quote] = profiles.css('.profile-quote').text if  profiles.css('.profile-quote')
      student_profile[:bio] = profiles.css("div.bio-content.content-holder div.description-holder p").text if profiles.css("div.bio-content.content-holder div.description-holder p")
    student_profile
  end

end
