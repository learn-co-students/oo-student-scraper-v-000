require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    roster = Nokogiri::HTML(open(index_url)).css(".student-card a")
    roster.each do |student|
      array << {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "./fixtures/student-site/#{student.attribute("href")}"
      }
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    hash = {} #need twitter, linkedin, github, blog, quote, bio
    student = Nokogiri::HTML(open(profile_url)).css(".main-wrapper")
    student_links = student.css(".social-icon-container a")#.attribute("href")
    student_links.each do |link|
      value = link.attribute("href").value
      if !value.match("linkedin").nil?
        hash[:linkedin] = value
      elsif !value.match("github").nil?
        hash[:github] = value
      elsif !value.match("twitter").nil?
        hash[:twitter] = value
      else
        hash[:blog] = value
      end
    end
    hash[:profile_quote] = student.css(".profile-quote").text
    hash[:bio] = student.css(".description-holder p").text
    hash
  end

end