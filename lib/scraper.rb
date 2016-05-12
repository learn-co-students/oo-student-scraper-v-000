require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    student_bio = doc.css(".student-card") #captures each student's personal bio info in a variable
    student_bio.each do |student| #each individual student HTML
      students << {:name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url =>"#{index_url}#{student.css("a").attribute("href").text}"
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_info = doc.css(".social-icon-container").children.css("a").map {|url| url.attribute('href').value}
    profile_page = {}
    student_info.each do |data|
      if data.include?("twitter")
        profile_page[:twitter] = data
      elsif data.include?("github")
        profile_page[:github] = data
      elsif data.include?("linked")
        profile_page[:linkedin] = data
      else
        profile_page[:blog] = data
      end
    end
    profile_page[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    profile_page[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    profile_page
  end
end
