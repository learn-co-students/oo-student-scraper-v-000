require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css('.student-card').each do |stud|
    student = {
      :name => stud.css('.student-name').text,
      :location => stud.css('.student-location').text,
      :profile_url => stud.at_css('a')['href']
    }
      students << student
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    html = File.read(profile_url)
    doc = Nokogiri::HTML(html)
    student = {}

    social_links = doc.css('.social-icon-container a')
      social_links.each do |link|
      if link.attr('href').include?("twitter")
        student[:twitter] = link.attr('href')
      elsif link.attr('href').include?("linkedin")
        student[:linkedin] = link.attr('href')
      elsif link.attr('href').include?("github")
      student[:github] = link.attr('href')
      else
        student[:blog] = link.attr('href')
      end
    end
    student[:profile_quote] = doc.css('.profile-quote').text
    student[:bio] = doc.css('div.description-holder p').text

    student

  end

end
