require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    page = Nokogiri::HTML(open(index_url))
    page.css("div.roster-cards-container").each do |card|
      page.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_profile_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student_profile = {}
      links = profile.css(".social-icon-container").children.css("a").map { |x| x.attribute('href').value}
      links.each do |link|
        if link.include?("twitter")
          student_profile[:twitter] = link
        elsif link.include?("linkedin")
          student_profile[:linkedin] = link
        elsif link.include?("github")
          student_profile[:github] = link
        else
          student_profile[:blog] = link
        end
    end
    student_profile[:profile_quote] = profile.css(".profile-quote").text
    student_profile[:bio] = profile.css(".description-holder p").text

    student_profile
  end

end
