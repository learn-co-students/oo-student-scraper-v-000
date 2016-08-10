require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []

    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = "./fixtures/student-site/" + student.css("a").attribute("href").value
      students << student_hash
    end
    students
    end

  def self.scrape_profile_page(profile_url)
    student_info = {}
    
    doc = Nokogiri::HTML(open(profile_url))
    
    doc.css(".vitals-container").each do |x|
      x.css("a").each do |site|
        if site.attribute("href").value.include?("linkedin")
          student_info[:linkedin] = site.attribute("href").value
        elsif site.attribute("href").value.include?("twitter")
          student_info[:twitter] = site.attribute("href").value
        elsif site.attribute("href").value.include?("git")
          student_info[:github] = site.attribute("href").value
        else
          student_info[:blog] = site.attribute("href").value
      end

      x.css(".vitals-text-container").each do |y|
        student_info[:profile_quote] = y.css(".profile-quote").text
      end
    end

    doc.css(".details-container").each do |x|
      x.css(".description-holder").css("p").each do |y|
        student_info[:bio] = y.text
      end
    end
  end

    student_info
  end


end

