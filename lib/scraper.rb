require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    index = Nokogiri::HTML(open(index_url))

    index.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_link = "#{student.attr('href')}"
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text

        students << {name: student_name, location: student_location, profile_url: student_link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    social = {}
    profile = Nokogiri::HTML(open(profile_url))

    icons = profile.css("div.social-icon-container").children.css("a").map {|a| a.attribute("href").value}
    icons.each do |icon|
      #binding.pry
      if icon.include?("twitter")
        social[:twitter] = icon
      elsif icon.include?("linkedin")
        social[:linkedin] = icon
      elsif icon.include?("github")
        social[:github] = icon
      else
        social[:blog] = icon
      end
    end
    social[:profile_quote] = profile.css("div.profile-quote").text
    social[:bio] = profile.css("div.bio-content.content-holder p").text
    social
  end

end
