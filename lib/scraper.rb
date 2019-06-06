require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    html = File.read(index_url)
    students = Nokogiri::HTML(html)

    students.css(".student-card").each do |student|
      url = student.css("a").attribute("href").value
      student_name = student.css("h4").text
      student_location = student.css("p").text
      array << {name: student_name, location: student_location, profile_url: url}

    end
    array
  end

  def self.scrape_profile_page(profile_url)
   profile = Nokogiri::HTML(open(profile_url))
   hash = {}
links = profile.css("body div.social-icon-container a").map do |element|
     element.attribute("href").value
   end
links.each do |link|
  if link.include?("twitter")
      hash[:twitter] = link
  elsif link.include?("github")
      hash[:github] = link
  elsif link.include?("linkedin")
      hash[:linkedin] = link
    else
      hash[:blog] = link
    end
  end
    hash[:profile_quote] = profile.css("div.profile-quote").text
    hash[:bio] = profile.css("div.description-holder p").text
    hash
  end











end
