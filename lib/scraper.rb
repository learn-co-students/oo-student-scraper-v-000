require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    fs = Nokogiri::HTML(File.read(index_url))
    
    students = []

    fs.css("div.student-card").each do |student|  
      student_info = {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => student.css("a").attribute("href").value}

      students << student_info
    end

    students
  end

  def self.scrape_profile_page(profile_url)    
    student = Nokogiri::HTML(File.read(profile_url))

    student_info = {}

    info = student.css("div.profile")

    social = info.css("div.social-icon-container a").collect {|i| i.attribute("href").value}

    social.each do |s|
      case
      when s.include?("linkedin")
        student_info[:linkedin] = s
      when s.include?("twitter")
        student_info[:twitter] = s
      when s.include?("github")
        student_info[:github] = s
      else
        student_info[:blog] = s
      end
    end

    student_info[:profile_quote] = info.css("div.profile-quote").text
    student_info[:bio] = info.css("div.bio-content p").text

    student_info
  end
end
