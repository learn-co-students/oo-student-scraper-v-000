require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        student_profile_url = student.attr("href")
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css(".description-holder p").text

    links = []
    profile_page.css(".social-icon-container a").each do |item|
      links << item.attribute("href").value
    end

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
    student 
  end

  #end of class
end
