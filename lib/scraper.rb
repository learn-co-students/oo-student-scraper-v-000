require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))

    students = [ ]

    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      student_profile_link = student.attr("href")
      students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end


  def self.scrape_profile_page(profile_url)

    profile_page = Nokogiri::HTML(open(profile_url))
    student = { }
      links = profile_page.css(".social-icon-container a").collect{|l|l.attribute("href").value}
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
        # student[:twitter] = link if link.include? "twitter"
        # student[:linkedin] = link if link.include? "linkedin"
        # student[:github] = link if link.include? "github"
        # student[:blog] = link if link
        student[:profile_quote] = profile_page.css(".profile-quote").text
        student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
        end
    student
  end
end
