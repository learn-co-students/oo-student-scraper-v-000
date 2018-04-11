require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

     student_site = Nokogiri::HTML(open(index_url))
     students = []

      student_site.css("div.roster-cards-container").each do |roster_card|
        roster_card.css(".student-card a").each do |student|

          student_profile_url = "#{student.attr('href')}"
          student_name = student.css(".student-name").text
          student_location = student.css(".student-location").text
          students << {name: student_name, location: student_location, profile_url: student_profile_url}
        end
      end
   students
    end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    social_links = profile_page.css(".social-icon-container").children.css("a").map { |z| z.attribute('href').value}  
      social_links.each do |link|

        if link.include?("linkedin")
          student_profile[:linkedin] = link
        elsif link.include?("github")
          student_profile[:github] = link
        elsif link.include?("twitter")
          student_profile[:twitter] = link
        else
          student_profile[:blog] = link

        end
      end

      student_profile[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      student_profile[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

      student_profile
    end

end
