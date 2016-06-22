require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = Nokogiri::HTML(open(index_url))
    student_collection = []
    students.css("div.student-card").each do |card|
      student_name = card.css("h4.student-name").text
      student_location = card.css("p.student-location").text
      student_page_address = "http://159.203.117.55:3024/#{card.css("a").attribute("href").value}"
      student_collection << {name: student_name, location: student_location, profile_url: student_page_address}
    end
    student_collection
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    student = {}

    social_media = profile.css("div.social-icon-container").each do |accounts|
      accounts.css("a").collect do |account|
        account.attribute("href").value
      end
    end
    social_media.each do |link|
      if link.include?("twitter")
        student[:twitter]=link
      elsif link.include?("linkedin")
        student[:linkedin]=link
      elsif link.include?("github")
        student[:github]=link
      else
        student[:blog]=link
      end
    end
    binding.pry
  end

end
