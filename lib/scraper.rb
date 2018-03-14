#####scrape_index_page
#is a class method that scrapes the student index page and a returns an array of hashes in which each hash represents one student
#####scrape_profile_page
#is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student
#can handle profile pages without all of the social links      

require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    index_page.css("div.roster-cards-container").each do |student_card|
      student_card.css(".student-card a").each do |student|
        student_profile_url = "./fixtures/student-site/#{student.attr("href")}"
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile = {}

    links = profile_page.css(".social-icon-container").children.css("a").collect { |link| link.attribute("href").value }
    links.each do |link|
      if link.include?("twitter")
        profile[:twitter] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end

    profile[:profile_quote] = profile_page.css(".profile-quote").text
    profile[:bio] = profile_page.css(".description-holder p").text
    profile
  end
end
