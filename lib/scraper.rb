require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css(".student-card").each do |student|
      student = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}

    doc.css(".social-icon-container a").each do |link|
      if link[:href].include?("twitter")
        student_profile[:twitter] = link["href"]
      elsif link[:href].include?("linkedin")
        student_profile[:linkedin] = link["href"]
      elsif link[:href].include?("github")
        student_profile[:github] = link["href"]
      else 
        student_profile[:blog] = link["href"]
      end
    end

    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".bio-content p").text

    student_profile
  end
end
