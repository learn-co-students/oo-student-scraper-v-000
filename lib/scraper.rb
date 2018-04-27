require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css("div.student-card").each do |student|
      student_profile_link = student.css("a").attribute("href").value
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      students << {name: student_name, location: student_location, profile_url: student_profile_link}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    students = {}

    links = doc.css("div.social-icon-container").css("a").map { |x| x.attribute("href").value }

    links.each do |link|
      if link.include?("linkedin")
        students[:linkedin] = link
      elsif link.include?("github")
        students[:github] = link
      elsif link.include?("twitter")
        students[:twitter] = link
      else
        students[:blog] = link
      end
    end
    students[:profile_quote] = doc.css(".profile-quote").text
    students[:bio] = doc.css("div.description-holder p").text

    students
    #doc.css("div.social-icon-container")<= contains links for social
    #doc.css("div.social-icon-container").css("a").attribute("href").value <= c
    #.css(".profile-quote").text <= quote
    #doc.css("div.description-holder p").text <=bio
  end
end
