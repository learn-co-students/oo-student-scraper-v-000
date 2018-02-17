require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css(".student-card").each do |student|
      student = {
        :profile_url => student.css("a").attribute("href").value,
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_page = Nokogiri::HTML(open(profile_url))
    student_info = {}
    student_page.css("div.social-icon-container a").each do |el|
      # soclink = (el.attribute("href").value).match(/\/\/(\w*)/).to_s[2..-1]
      if el.attribute("href").value.include?("twitter")
      student_info[:twitter] = el.attribute("href").value
    elsif el.attribute("href").value.include?("linkedin")
        student_info[:linkedin] = el.attribute("href").value
      elsif el.attribute("href").value.include?("github")
        student_info[:github] = el.attribute("href").value
      else
        student_info[:blog] = el.attribute("href").value
      end
    end
    student_info[:profile_quote] = student_page.css(".profile-quote").text
    student_info[:bio] = student_page.css(".description-holder p").text
    student_info
  end

end
