require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))
     students = []

      doc.css(".student-card a").each do |card|
         student_name = card.css("h4").text #.student-name
         student_location = card.css("p").text #.student-location
         student_profile_url = "#{card.attr('href')}"
         students << {name: student_name, location: student_location, profile_url: student_profile_url}
        end
     students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}

      links = doc.css(".social-icon-container a").collect{|attribute| attribute['href']}
      links.each do |link|
        if link.include?("github")
          student[:github] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("twitter")
          student[:twitter] = link
        else
          student[:blog] = link
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css(".bio-content.content-holder div.description-holder p").text
    student
  end

end
