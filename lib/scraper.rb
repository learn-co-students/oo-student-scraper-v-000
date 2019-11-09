require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_link = student.attr('href')

        students << {name: student_name, location: student_location, profile_url: student_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}

    doc.css("div.social-icon-container a").each do |social|
      link = social.attributes["href"].value
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?("facebook")
          student[:facebook] = link
        elsif link.include?("bookmark")
          student[:bookmark] = link
        else
          student[:blog] = link
        end
    end

    student[:profile_quote] = doc.css("div.profile-quote").children.text

    student[:bio] = doc.css("div.description-holder p").text

    student
  end

end
