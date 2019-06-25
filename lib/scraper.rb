require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
      students = []
      html = open(index_url)
      index = Nokogiri::HTML(html)
      index.css("div.student-card").each do |student|
        student_card = {}
        student_card[:name] = student.css("h4.student-name").text
        student_card[:location] = student.css("p.student-location").text
        student_card[:profile_url] = student.css("a").attribute("href").value
        students << student_card
      end
      students
    end

    # this is a student_card
  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end
    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

    student_profile
  end
end
