require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_reader :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    require 'open-uri'
    doc = Nokogiri::HTML(open("./fixtures/student-site/index.html"))
    students = []
    doc.css(".student-card").each do |card|
      student = {}
      student[:profile_url] = card.css("a")[0].attr("href")
      student[:name] = card.css("h4").text
      student[:location] = card.css("p").text
      students << student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    individual_student = {}
    require 'open-uri'
    doc = Nokogiri::HTML(open(profile_url))
    doc.css(".social-icon-container a").each do |link|
      href = link.attr("href")
      if href.include?("twitter")
        individual_student[:twitter] = href
      elsif href.include?("linkedin")
        individual_student[:linkedin] = href
      elsif href.include?("github")
        individual_student[:github] = href
      else
        individual_student[:blog] = href
      end
    end
    individual_student[:profile_quote] = doc.css(".profile-quote").text
    individual_student[:bio] = doc.css("p").text
    individual_student
  end

end
