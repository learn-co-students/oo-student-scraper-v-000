require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    students = []

    index.css("div.student-card").each do |student|
      student_info = {:name => student.css("h4.student-name").text, :location => student.css("p.student-location").text, :profile_url => student.css("a").attribute("href").value}

      students << student_info
    end

    students
  end

  def self.scrape_profile_page(profile_url)    
    student = {}
    page = Nokogiri::HTML(File.read(profile_url))
    student_info = page.css("div.profile")
    urls = student_info.css("div.social-icon-container a").collect {|i| i.attribute("href").value}

    urls.each do |s|
      case
      when s.include?("linkedin")
        student[:linkedin] = s
      when s.include?("twitter")
        student[:twitter] = s
      when s.include?("github")
        student[:github] = s
      else
        student[:blog] = s
      end
    end

    student[:profile_quote] = student_info.css("div.profile-quote").text if student_info.css("div.profile-quote")
    student[:bio] = student_info.css("div.bio-content p").text if student_info.css("div.bio-content p")

    student
  end
end
