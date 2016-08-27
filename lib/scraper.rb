require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css('div.roster-cards-container').each do |card|
      card.css('.student-card a').each do |student|
        student_profile_link = "./fixtures/student-site/#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << { name: student_name, location: student_location, profile_url: student_profile_link }
      end
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))

    student_info = {}


    links = profile_page.css('.social-icon-container').children.css('a').map do |url|
      url.attribute('href').value
    end


    links.each do |link|
      if link.include?('linkedin')
        student_info[:linkedin] = link
      elsif link.include?('github')
        student_info[:github] = link
      elsif link.include?('twitter')
        student_info[:twitter] = link
      else
        student_info[:blog] = link
      end
    end

    if profile_page.css('profile-quote')
      student_info[:profile_quote] = profile_page.css('.profile-quote').text
    end

    if profile_page.css('div.bio-content.content-holder div.description-holder p')
      student_info[:bio] = profile_page.css('div.bio-content.content-holder div.description-holder p').text
    end

    student_info
  end
end
