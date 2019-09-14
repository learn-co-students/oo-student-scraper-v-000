require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |info|
      info.css("div.student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_url = "#{student.attribute("href")}"
        students << {name: student_name, location: student_location, profile_url: student_profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    sm_links = doc.css(".social-icon-container").children.css("a").map {|link| link.attribute("href").value}
    sm_links.each do |sm_link|
      if sm_link.include?("twitter")
        student[:twitter] = sm_link
      elsif sm_link.include?("linkedin")
        student[:linkedin] = sm_link
      elsif sm_link.include?("github")
        student[:github] = sm_link
      else
        student[:blog] = sm_link
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")

    student
  end
end
