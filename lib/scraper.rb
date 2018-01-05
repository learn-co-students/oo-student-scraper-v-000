require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    profiles = Nokogiri::HTML(html)
    students = []
    profiles.css("div.roster-cards-container").each do |container|
      container.css(".student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_url = "#{student.attr('href')}"
        students << {name: student_name, location: student_location, profile_url: student_url}
      end
    end
      students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    s_profiles = profile.css(".social-icon-container a").map do |socials|
      socials.attr("href")
    end
    student = {}
    s_profiles.each do |profile|

      if profile.include?("linkedin")
        student[:linkedin] = profile
      elsif profile.include?("github")
        student[:github] = profile
      elsif profile.include?("twitter")
        student[:twitter] = profile
      else
        student[:blog] = profile
      end
    end
    student[:bio] = profile.css(".details-container .description-holder p").text
    student[:profile_quote] = profile.css(".profile-quote").text
    student
  end

end
