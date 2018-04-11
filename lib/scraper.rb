require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    homepage = Nokogiri::HTML(open(index_url))
    students = []

    homepage.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = "#{student.attr("href")}"
        students << {:name => student_name, :location => student_location, :profile_url => student_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}


      social = profile_page.css(".social-icon-container").children.css("a").map { |a| a.attribute("href").value }
        social.each do |link|
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
      student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
      student

  end

end
