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
    attributes = {}
    links = profile_page.css('.social-icon-container a').map {|l| l.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        attributes[:linkedin] = link
      elsif link.include?("github")
        attributes[:github] = link
      elsif link.include?("twitter")
        attributes[:twitter] = link
      else
        attributes[:blog] = link
      end
    end
    attributes[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    attributes[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
    attributes
  end

end
