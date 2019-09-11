require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      indexdoc = Nokogiri::HTML(html = open(index_url))
      students = []
      indexdoc.css(".roster-cards-container").each do |card|
        card.css(".student-card a").each do |student|
          student_name = student.css(".student-name").text
          location_name = student.css(".student-location").text
          link = student.attr('href')
          students << {name: student_name, location: location_name, profile_url: link}
        end
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    profiledoc = Nokogiri::HTML(html = open(profile_url))
    student = {}
    links = profiledoc.css(".social-icon-container").children.css("a").collect { |link| link.attribute('href').value}
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
    student[:profile_quote] = profiledoc.css(".profile-quote").text
    student[:bio] = profiledoc.css(".description-holder p").text
    student
  end

end
