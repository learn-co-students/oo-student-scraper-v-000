require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
        # .student-card .card-text-container .student-name / .student-location
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        link = "http://127.0.0.1:4000/#{student.attr('href')}"
        location = student.css(".student-location").text
        name = student.css(".student-name").text
        students << {name: name, location: location, profile_url: link}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    #needs :twitter, :linkedin, :github, :blog, :profile_quote, :bio
    student_info = {}

    social_media = profile.css(".social-icon-container").children.css("a").map {|link| link.attribute("href").value}
    social_media.each do |link|
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
    student_info[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
    student_info[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p")
    student_info
  end

end

