require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './student.rb'

class Scraper


  def self.scrape_index_page(index_url)
    html = open('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)

    student_hash_array = []
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      student_hash_array << student_hash
    end
    student_hash_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    scraped_student = {}
    scraped_student[:bio] = doc.css(".description-holder").css("p").text
    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    links = doc.css(".social-icon-container").css("a")
    links.each do |link|
      if link['href'].include?("github")
        scraped_student[:github] = link['href']
      elsif link['href'].include?("linkedin")
        scraped_student[:linkedin] = link['href']
      elsif link['href'].include?("twitter")
        scraped_student[:twitter] = link['href']
      elsif link['href'].include?(".com")
        scraped_student[:blog] = link['href']
      end
    end
    scraped_student
  end




end
