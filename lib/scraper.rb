require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []
    page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a"). each do |student|
        profile = "./fixtures/student-site/#{student.attr("href")}"
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        students << {profile_url: profile, name: name, location: location}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    links = page.css(".social-icon-container").css("a").map {|link| link.attribute("href").value}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-content p").text
    student
  end
end
