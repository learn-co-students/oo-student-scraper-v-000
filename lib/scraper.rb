require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        student_link = student['href']
        students << {name: student_name, location: student_location, profile_url: student_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
    links = profile_page.css(".social-icon-container").children.css("a").map {|element| element.attribute('href').value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student
  end



end
