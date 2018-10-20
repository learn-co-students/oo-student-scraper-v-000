require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").each do |student|
      student_info = {}
      student_info[:name] = student.css("h4").text
      student_info[:location] = student.css("p").text
      student_info[:profile_url] = student.css("a").attribute("href").value
      students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_prof = {}
    doc.css(".social-icon-container").css("a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_prof[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_prof[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_prof[:github] = social.attribute("href").value
      else
        student_prof[:blog] = social.attribute("href").value
      end
    end
    student_prof[:profile_quote] = doc.css(".profile-quote").text
    student_prof[:bio] = doc.css(".description-holder").css("p").text

    student_prof
  end

end



#name = doc.css(".student-card").first.css("h4").text
#location = doc.css(".student-card").first.css("p").text
#url = doc.css(".student-card").first.css("a").attribute("href").value
#quote = doc.css(".profile-quote").text
#bio = doc.css(".description-holder").css("p").text
