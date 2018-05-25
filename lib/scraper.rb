require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    student_information = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = doc.css("div .student-card")
    students.each do |student_card|
        #binding.pry
        student_profile_url = student_card.css("a").attribute("href").value #profile_url
        student_location = student_card.children.css("p").children.first.text #location
        student_name = student_card.children.css("h4").children.first.text
        student_information << {name: student_name, location: student_location, profile_url: student_profile_url}
    end
    student_information
  end

  def self.scrape_profile_page(profile_url)
    profile_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student = doc.css("div .social-icon-container").children.css("a").map{|tag| tag.attribute("href").value}

    student.each do |link|
      if link.include?("twitter")
        profile_hash[:twitter] = link
      elsif link.include?("linkedin")
        profile_hash[:linkedin] = link
      elsif link.include?("github")
        profile_hash[:github] = link
      else
        profile_hash[:blog] = link

        #binding.pry
       end
     end
    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text
    profile_hash
  end

end
