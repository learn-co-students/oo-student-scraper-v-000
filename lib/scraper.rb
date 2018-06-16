require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    students_info = doc.css(".student-card")
    students_info.each do |student_info|
      student = {
        name: student_info.css(".student-name").text,
        location: student_info.css(".student-location").text,
        profile_url: student_info.css("a").attribute("href").value
      }
      students << student
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    twitter_handle = ""
    linkedin_handle = ""
    github_handle = ""
    blog_handle = ""
    social_links = doc.css(".social-icon-container").css("a")
    social_links.each do |links|
      social_icon = links.attribute("href").value
      if social_icon.include?("twitter")
        twitter_handle = social_icon
      elsif social_icon.include?("linkedin")
        linkedin_handle = social_icon
      elsif social_icon.include?("github")
        github_handle = social_icon
      else
        blog_handle = social_icon
      end
    end
    student_info = {
      :twitter => twitter_handle,
      :linkedin => linkedin_handle,
      :github => github_handle,
      :blog => blog_handle,
      :profile_quote => doc.css(".profile-quote").text,
      :bio => doc.css(".description-holder").css("p").text
    }
    student_info
end

Scraper.scrape_index_page("./fixtures/student-site/index.html")
Scraper.scrape_profile_page("./fixtures/student-site/students/ryan-johnson.html")
