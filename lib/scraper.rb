require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    Nokogiri::HTML(open(index_url)).css(".student-card").each do |student|
      student_info = {}
      student_info[:name] = student.css("h4.student-name").text
      student_info[:location] = student.css("p.student-location").text
      student_info[:profile_url] = "http://127.0.0.1:4000/#{student.css("a").attribute("href").value}"
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    snl = doc.css(".social-icon-container a") #snl = social network link
    student_info = {}

    snl.each do |social|
      if social.attribute("href").value.include?("twitter")
        student_info[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_info[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_info[:github] = social.attribute("href").value
      else
        student_info[:blog] = social.attribute("href").value
      end
    end

    student_info[:profile_quote] = doc.css("div.profile-quote").text
    student_info[:bio] = doc.css("div.description-holder p").text
    student_info

  end

end
