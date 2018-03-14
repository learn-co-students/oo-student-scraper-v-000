require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(open(index_url))
    students = []

    html.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "#{student.attr('href')}"
        students << {name: name, location: location, profile_url: profile_url}
      end
    end

    students

  end

  def self.scrape_profile_page(profile_url)
    student_html = Nokogiri::HTML(open(profile_url))
    student = {}
    links = student_html.css("div.social-icon-container a").map do |link|
      link.attribute('href').value
    end

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

    student[:profile_quote] = student_html.css("div.profile-quote").text
    student[:bio] = student_html.css("div.bio-block.details-block p").text

    student
  end

end
