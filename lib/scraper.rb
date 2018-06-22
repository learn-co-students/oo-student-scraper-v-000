#require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open('./fixtures/student-site/index.html')
    doc = Nokogiri::HTML(html)
    student_names = doc.css(".student-name").map{|name| name.text}
    student_locations = doc.css(".student-location").map{|location| location.text}
    student_links = doc.css(".student-card").css("a").map{|link| link['href']}

    students = []
    i = 0
    while i < student_names.length
    students << {name: "#{student_names[i]}", location: "#{student_locations[i]}", profile_url: "#{student_links[i]}"}
    i += 1
  end
  students
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    student_profile = {}
    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".description-holder p").text

    social_media = doc.css(".social-icon-container").css("a").map{|link| link['href']}
      social_media.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile
  end

end
