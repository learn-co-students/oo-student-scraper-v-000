require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url)).css(".roster-cards-container")

    students = doc.collect do |s|
      s.css(".student-card").collect do |s|
        {:name => s.css("h4").text,
         :location => s.css("p").text,
         :profile_url => s.css("a").attr("href").value
       }
      end
    end
    students.flatten
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url)).css("body")
    social = doc.css(".social-icon-container").css("a")
    student_profile = {}

    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css("div.description-holder p").text

      social.each do |link|
        if link.attr("href").include?("twitter")
          student_profile[:twitter] = link.attr("href")
        elsif link.attr("href").include?("linkedin")
          student_profile[:linkedin] = link.attr("href")
        elsif link.attr("href").include?("github")
          student_profile[:github] = link.attr("href")
        else
          student_profile[:blog] = link.attr("href")
        end
      end
      student_profile
  end

end
