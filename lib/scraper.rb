require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

@@scraped_students = []

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css("div.student-card")
    students.each do |student|
      scraped_student = {}
      scraped_student[:name] = student.css("div.card-text-container h4.student-name").text
      scraped_student[:location] = student.css("p.student-location").text
      scraped_student[:profile_url] = student.css("a").attribute("href").value
      @@scraped_students << scraped_student
    end
    @@scraped_students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile = doc.css("div.main-wrapper")
    social_links = doc.css("div.social-icon-container a")
    social_links.each do |social_link|
      link = social_link.attribute("href").value
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
    student[:profile_quote] = profile.css("div.profile-quote").text
    student[:bio] = profile.css("div.description-holder p").text
    student
  end
end
