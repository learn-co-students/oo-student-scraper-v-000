require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :location, :name, :profile_url
  attr_reader :twitter, :linkedin, :github, :blog, :profile_quote, :bio

  def self.scrape_index_page(index_url)
    index_url = "./fixtures/student-site/index.html"
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        # binding.pry
      student_profile_link = "#{student.attr('href')}"
      student_location = student.css(".student-location").text
      student_name = student.css(".student-name").text

    scraped_students << {:name => student_name, :location => student_location, :profile_url => student_profile_link}
      end
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    links = profile_page.css(".social-icon-container").children.css("a").map { |element| element.attribute('href').value}
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end

    student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    student[:bio] = profile_page.css(".description-holder p").text if profile_page.css(".description-holder p").text

    student
  end

end
