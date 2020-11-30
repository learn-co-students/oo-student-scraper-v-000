require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []

    students_container = index_page.css(".roster-cards-container")

    students_container.each do |student_cards|
      student_cards.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text.strip
        student_location = student.css(".student-location").text.strip
        student_profile_url = student.attr("href")
        students << {:name => student_name, :location => student_location, :profile_url => student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    social_media_links = profile_page.css(".social-icon-container a").map{|l| l.attr("href")}
    social_media_links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin]= link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end

    profile_quote = profile_page.css(".vitals-text-container .profile-quote").text
    student[:profile_quote] = profile_quote

    bio = profile_page.css(".details-container div.description-holder p").text
    student[:bio] = bio

    student
  end

end
