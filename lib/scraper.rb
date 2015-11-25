require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    scraped_students = []

    doc.css(".student-card").each do |student|
      student_info = {}
      student_info[:name]= student.css("h4").text
      student_info[:location]= student.css("p").text
      student_info[:profile_url]= "http://students.learn.co/#{student.css("a")[0]["href"]}"
      scraped_students << student_info
    end

    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_info = {}

    doc.css(".social-icon-container a").each do |social|
      if social.include?("twitter")
        student_info[:twitter]= doc.css(".social-icon-container a")[0]["href"]
      elsif social.include?("linkedin")
        student_info[:linkedin]= doc.css(".social-icon-container a")[0]["href"]
      elsif social.include?("github")
        student_info[:github]= doc.css(".social-icon-container a")[0]["href"]
      elsif social.include?(".com")
        student_info[:blog]= doc.css(".social-icon-container a")[0]["href"]
      end
    end

    student_info[:profile_quote]= doc.css(".vitals-text-container .profile-quote").text
    student_info[:bio]= doc.css(".details-container .description-holder p").text
  
    student_info
  end

end
