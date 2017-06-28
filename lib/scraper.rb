require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_site = Nokogiri::HTML(open(index_url))
    students = []
    student_site.css(".student-card a").each do |student_info|
      student = {}
      student[:name] = student_info.css(".student-name").text
      student[:location] = student_info.css(".student-location").text
      student[:profile_url] = "#{student_info.attr('href')}"
      students << student
    end
   students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    student = {}

    social_container = student_profile.css("div.social-icon-container a")
    social_container.each do |social_link|
      link = social_link.attribute('href').value
      if link.include? 'twitter'
        student[:twitter] = link
      elsif link.include? 'github'
        student[:github] = link
      elsif link.include? 'linkedin'
        student[:linkedin] = link
      elsif link.include? 'facebook'
        student[:facebook] = link
      elsif link.include? 'youtube'
        student[:youtube] = link
      else
        student[:blog] = link
      end
    end
    profile_quote = student_profile.css("div.vitals-text-container div.profile-quote").text
    student[:profile_quote] = profile_quote if profile_quote
    bio = student_profile.css("div.description-holder p").text
    student[:bio] = bio if bio
    student
  end
end

#Scraper.scrape_profile_page("./fixtures/student-site/students/ryan-johnson.html")
Scraper.scrape_index_page("./fixtures/student-site/index.html")
