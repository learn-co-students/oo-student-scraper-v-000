require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []
    index.css("div.roster-cards-container").each do |student|
      student.css("div.student-card a").each do |feature|
        student_name = feature.css("h4.student-name").text
        student_location = feature.css("p.student-location").text
        student_url = "#{feature.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    index = Nokogiri::HTML(open(profile_url))
    student = {}
    links = index.css(".social-icon-container").children.css("a").map { |l| l.attribute('href').value}
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
    student[:profile_quote] = index.css('.profile-quote').text if index.css('.profile-quote')
    student[:bio] = index.css("div.bio-content.content-holder div.description-holder p").text if index.css("div.bio-content.content-holder div.description-holder p")

    student
  end

end
