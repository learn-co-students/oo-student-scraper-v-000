require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  # def self.get_page_content(page_url)
  #   Nokogiri::HTML(open(page_url))
  # end

  def self.scrape_index_page(index_url)
    index_content = Nokogiri::HTML(open(index_url))
    students = []
    index_content.css('div.roster-cards-container div.student-card').each do |student_card|
      student_hash = {}
      student_hash[:name] = student_card.css('h4.student-name').text
      student_hash[:location] = student_card.css('p.student-location').text
      student_hash[:profile_url] = student_card.css('a').attr('href').value
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profiles = Nokogiri::HTML(open(profile_url))
    social_hash = {}
    links = student_profiles.css('div.social-icon-container a').map do |link|
      link.attribute('href').value
    end

    links.each do |link|
      if link.include?("twitter")
        social_hash[:twitter] = link
      elsif link.include?("linkedin")
        social_hash[:linkedin] = link
      elsif link.include?("github")
        social_hash[:github] = link
      else
        social_hash[:blog] = link
      end
    end
    social_hash[:profile_quote] = student_profiles.css('div.profile-quote').text
    social_hash[:bio] = student_profiles.css('div.bio-block.details-block p').text

    social_hash

  end

end
