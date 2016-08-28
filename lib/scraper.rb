require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a"). each do |student|
        student_link = "./fixtures/student-site/#{student.attr("href")}"
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        students << {name: student_name, location: student_location, profile_url: student_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    links = page.css(".social-icon-container").children.css("a").map { |link| link.attribute("href").value }
    links.each do |l|
      if l.include?("twitter")
        student[:twitter] = l
      elsif l.include?("linkedin")
        student[:linkedin] = l
      elsif l.include?("github")
        student[:github] = l
      else
        student[:blog] = l
      end
    end
    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-content p").text
      #profile quote, and bio
    student
  end

end
