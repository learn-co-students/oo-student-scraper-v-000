require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))

    students = []

    index_page.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|
      url = "#{student.attr("href")}"
      student_name = student.css(".student-name").text
      student_location = student.css(".student-location").text
      students << {name: student_name, location: student_location, profile_url: url}
      end
    end

    students
  end


  def self.scrape_profile_page(profile_url)
    student = {}
    profile_page = Nokogiri::HTML(open(profile_url))
    links = profile_page.css(".social-icon-container").children.css("a").map { |a| a.attribute('href').value }
      links.each do |link|
        if link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("github")
          student[:github] = link
        else
          student[:blog] = link
        end
        student[:bio] = profile_page.css("div.description-holder p").text
        student[:profile_quote] = profile_page.css("div.profile-quote").text
      end
      student
    end

end
