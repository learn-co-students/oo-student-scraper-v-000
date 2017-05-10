require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    scraped_students = []

    doc.css("div.student-card").each do |student|
      scraped_students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text, profile_url: "http://students.learn.co/#{student.css("a").attribute("href").value}"}
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_details = {}

    doc.css("div.social-icon-container").each do |social_media|
      if social_media.include?("twitter")
        student_details[:twitter] = doc.css("div.social-icon-containter")[0]["href"]
      elsif social_media.include?("linkedin")
        student_details[:linkedin] = doc.css("div.social-icon-containter")[0]["href"]
      elsif social_media.include?("github")
        student_details[:github] = doc.css("div.social-icon-containter")[0]["href"]
      elsif social_media.include?(".com")
        student_details[:blog]= doc.css("div.social-icon-container a")[0]["href"]
      end
    end

    student_details[:profile_quote] = doc.css("div.vitals-text-container.profile-quote").text
    student_details[:bio] = doc.css("div.details-container.description-holder p").text

    student_details

  end

end
