require 'open-uri'
require 'nokogiri'
require 'rubygems'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)

    students = []

    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|

        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_url = student.attr('href')
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

#twitter url, linkedin url, github url, blog url, profile quote, and bio.
  def self.scrape_profile_page(profile_url)

    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)

    student = {}

    links = profile_page.css("div.social-icon-container a").map { |l| l.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = profile_page.css("div.profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text

    student
  end


end
