require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :name, :location, :profile_url
  @@all = []
  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card a").each do |post|
      student_name = post.css("h4").text
      student_location = post.css("p").text
      student_profile_url = "#{post.attr('href')}"
      students << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
    students
  end


  def self.scrape_profile_page(profile_url)
    student = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_name = doc.css(".profile-name").css("h1").text
    links = doc.css(".social-icon-container a").collect { |a| a.attribute('href').value}
    links.each do |link|
      if link.split("/").include?("linkedin.com") || link.split("/").include?("www.linkedin.com")
        student[:linkedin] = link
      elsif link.split("/").include?("github.com") || link.split("/").include?("www.github.com")
        student[:github] = link
      elsif link.split("/").include?("twitter.com") || link.split("/").include?("www.twitter.com")
        student[:twitter] = link
      elsif link.include?(student_name.split(" ")[0].downcase)
        student[:blog] = link
      end
    end
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css(".description-holder").css("p").text if doc.css(".description-holder").css("p")
    student
  end




end
