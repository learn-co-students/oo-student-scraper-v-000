require 'open-uri'
require "nokogiri"
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_index_array = []
    students = doc.css(".student-card")
    students.each do |student|
      student_hash = {
      :name => student.css(".student-name").text,
      :location => student.css(".student-location").text,
      :profile_url => "./fixtures/student-site/#{student.css("a").attribute("href").value}"
    }
      student_index_array << student_hash
    end
    student_index_array
  end
  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}
    links = profile.css(".social-icon-container a")
    social_links = []
    links.each do |item|
      social_links << item.attribute("href").value
    end

    social_links.each do |link|
      if link.include?("twitter")
        student[:twitter]
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin]
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github]
        student[:github] = link
      else
        student[:blog]
        student[:blog] = link
      end
    end
    profile_quote = profile.css(".profile-quote").text
    bio = profile.css(".bio-content p").text
    student[:profile_quote]
    student[:profile_quote] = profile_quote
    student[:bio]
    student[:bio] = bio

    student
  end
end
