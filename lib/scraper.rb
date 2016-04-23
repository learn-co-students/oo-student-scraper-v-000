require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
        students = []
        index_page = Nokogiri::HTML(open(index_url))
        index_page.css("div.roster-cards-container").each do |card|
            card.css(".student-card a").each do |student|
                student_name = student.css(".student-name").text
                student_location = student.css(".student-location").text
                student_profile_link = "http://127.0.0.1:4000/#{student.attr("href")}"
                students << {name: student_name, location: student_location, profile_url: student_profile_link}
            end
        end
        students
    end
    def self.scrape_profile_page(profile_url)
        student_info = {}
        page = Nokogiri::HTML(open(profile_url))
        links = page.css(".social-icon-container").children.css("a").map{|a| a.attribute("href").value}
        links.each do |link|
            if link.include?("linkedin")
                student_info[:linkedin] = link
            elsif link.include?("github")
                student_info[:github] = link
            elsif link.include?("twitter")
                student_info[:twitter] = link
            else
                student_info[:blog] = link
            end
        end
        student_info[:profile_quote] = page.css(".profile-quote").text if page.css(".profile-quote")
        student_info[:bio] = page.css("div.bio-content.content-holder div.description-holder p").text if page.css("div.bio-con         tent.content-holder div.description-holder p")
        student_info
    end
end

