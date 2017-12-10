require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_link = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {name: student_name, location: student_location, profile_url: student_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    icons = profile_page.css(".social-icon-container").children.css("a").map { |a| a.attribute("href").value}
    icons.each do |icon|
      if icon.include?("twitter")
        student[:twitter] = icon
      elsif icon.include?("linkedin")
        student[:linkedin] = icon
      elsif icon.include?("github")
        student[:github] = icon
      else
        student[:blog] = icon
      end
    end
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".bio-content.content-holder p").text
    student
  end
end
