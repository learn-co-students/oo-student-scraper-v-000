require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    html = open(index_url)
    doc = Nokogiri::HTML(html)
    roster = doc.search("div.student-card")

    students = []

    roster.collect do |student|
      students << {
        name: student.search("h4.student-name").text,
        location: student.search("p.student-location").text,
        profile_url: "http://127.0.0.1:4000/#{student.search("a").attr("href")}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    

    student_hash = {}

    doc.css(".social-icon-container a").each do |a|
      link = a.attr("href")
      if link.include? "twitter"
        student_hash[:twitter] = link
      elsif link.include? "linkedin"
        student_hash[:linkedin] = link
      elsif link.include? "github"
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash[:profile_quote] = doc.css("div.profile-quote").text
    student_hash[:bio] = doc.css("div.description-holder p").text
    student_hash
  end

end

