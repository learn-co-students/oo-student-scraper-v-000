require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    file = Nokogiri::HTML(open(index_url))
    students = []

    file.css("div.student-card").each do |card|
      student_info = {
        :name => card.css("h4.student-name").text,
        :location => card.css("p.student-location").text,
        :profile_url => card.css("a").attr("href").value
      }
    students << student_info
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
      student_profile = {}
      profile.css(".social-icon-container a").each do |icon|
        address = icon.attr("href")
        case
        when address.include?("twitter")
          student_profile[:twitter] = address
        when address.include?("linkedin")
          student_profile[:linkedin] = address
        when address.include?("github")
          student_profile[:github] = address
        else
          student_profile[:blog] = address
        end
      end
      student_profile[:profile_quote] = profile.css(".profile-quote").text
      student_profile[:bio] = profile.css(".description-holder p").text
      student_profile
    end








end
