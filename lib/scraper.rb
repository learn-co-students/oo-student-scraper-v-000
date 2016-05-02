require 'open-uri'
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
    social_link = doc.css(".social-icon-container a")
    profile_info = {}

    social_link.each do |link|
      if link.attribute("href").value.include?("twitter")
        profile_info[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        profile_info[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        profile_info[:github] = link.attribute("href").value
      else
        profile_info[:blog] = link.attribute("href").value
      end
    end

    profile_info[:profile_quote] = doc.css("div.profile-quote").text
    profile_info[:bio] = doc.css("div.description-holder p").text
    profile_info

  end

end
