require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students_cards = Nokogiri::HTML(open(index_url)).css("div.student-card a")
    students = []

    students_cards.each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".card-text-container h4.student-name").text
      student_hash[:location] = student.css(".card-text-container p.student-location").text
      student_hash[:profile_url] = student["href"]
      students << student_hash
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    student_info_top = Nokogiri::HTML(open(profile_url)).css("div.vitals-container")

    social_links = student_info_top.css("div.social-icon-container a")

    social_links.each do |link|
      if link["href"].include? "linkedin"
        student_hash[:linkedin] = link["href"]
      elsif link["href"].include? "github"
        student_hash[:github] = link["href"]
      elsif link["href"].include? "twitter"
        student_hash[:twitter] = link["href"]
      else
        student_hash[:blog] = link["href"]
      end

    end

    student_hash[:profile_quote] = student_info_top.css("div.vitals-text-container div.profile-quote").text


    student_info_bottom = Nokogiri::HTML(open(profile_url)).css("div.details-container")
    student_hash[:bio] = student_info_bottom.css("div.description-holder p").text
    
    student_hash
  end

end
