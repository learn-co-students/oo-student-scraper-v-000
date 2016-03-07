require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css("div.student-card a").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      url = "http://127.0.0.1:4000/#{student["href"]}"
      scraped_students << {name: name, location: location, profile_url: url}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    scraped_student = {}
    links = []

    student = Nokogiri::HTML(open(profile_url))
    student.css("div.social-icon-container a").each do |link|
      links << link["href"]
      links.each do |link|
        if link.include?("twitter")
          scraped_student[:twitter] = link
        elsif link.include?("linkedin")
          scraped_student[:linkedin] = link
        elsif link.include?("github")
          scraped_student[:github] = link
        else
          scraped_student[:blog] = link
        end
      end
    end

    scraped_student[:profile_quote] =student.css(".profile-quote").text
    scraped_student[:bio] = student.css("p").text
    scraped_student
  end

end
