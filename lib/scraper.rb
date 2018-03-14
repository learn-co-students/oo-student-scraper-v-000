require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "./fixtures/student-site/#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_social_media = {}
    social_media_links = []
    profile_page.css("div.social-icon-container").each do |social_icon|
      social_media_links = social_icon.children.css("a").map{|e| e.attribute('href').value}
    end

    social_media_links.each do |link|
      if link.include?("twitter")
        student_social_media[:twitter] = link
      elsif link.include?("facebook")
        student_social_media[:facebook] = link
      elsif link.include?("github")
        student_social_media[:github] = link
      elsif link.include?("linkedin")
        student_social_media[:linkedin] = link
      else
        student_social_media[:blog] = link
      end
    end
    student_social_media[:profile_quote] = profile_page.css('.profile-quote').text
    student_social_media[:bio] = profile_page.css('.description-holder p').text
    student_social_media
  end

end
