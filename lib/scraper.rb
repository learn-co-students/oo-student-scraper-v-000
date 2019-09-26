require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  #name = student.css("h4 .student-name").text
  #location = student.css("p").text
  #profile_url = student.css("a").attribute("href").value

  def self.scrape_index_page(index_url)
    html = open(index_url)
    flatiron_students = Nokogiri::HTML(html)
    students = []

    flatiron_students.css(".student-card").each do |student|
      student_hash = Hash.new()
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      students << student_hash
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student = Nokogiri::HTML(html)
    social_info = {}

    social_media = student.css(".social-icon-container a")

    #quote: student.css(".vitals-text-container .profile-quote").text
    #bio: student.css(".description-holder p").text

    array = []

    social_media.each do |website|
      array << social_media.attribute("href").value
      social_media.shift
    end

    array.each do |link|
      if link.include?("twitter")
        social_info[:twitter] = link
      elsif link.include?("linkedin")
        social_info[:linkedin] = link
      elsif link.include?("github")
          social_info[:github] = link
      else
          social_info[:blog] = link
      end

      
      # keyword = link.split("/")[2].split(".")
      # if keyword.include?("twitter")
      #   social_info[:twitter] = link
      # elsif keyword.include?("linkedin")
      #   social_info[:linkedin] = link
      # elsif keyword.include?("github")
      #   social_info[:github] = link
      # else
      #   social_info[:blog] = link
      # end
    end

    social_info[:profile_quote] = student.css(".vitals-text-container .profile-quote").text
    social_info[:bio] = student.css(".description-holder p").text

    social_info
  end

end
