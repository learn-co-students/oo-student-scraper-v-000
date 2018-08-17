require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    # doc.css(".student-card") => provides the individual student objects
    # doc.css(".student-card").first.css(".student-name").text => provides the student's name
    # doc.css(".student-card").first.css(".student-location").text => provides the student's location
    # doc.css(".student-card").first.css("a").map {|link| link['href']}[0]

    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").map {|link| link['href']}[0]
      students << student_hash
      #binding.pry
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text

    doc.css(".social-icon-container a").map {|link| link['href']}.each do |social|
      if social.include?("linkedin")
        profile_hash[:linkedin] = social
      elsif social.include?("twitter")
        profile_hash[:twitter] = social
      elsif social.include?("github")
        profile_hash[:github] = social
      else
        profile_hash[:blog] = social
      end
    end


    # doc.css(".social-icon-container a").map {|link| link['href']}[0] => Twitter Profile link, string
    # doc.css(".social-icon-container a").map {|link| link['href']}[1] => Linkedin Profile link, string
    # doc.css(".social-icon-container a").map {|link| link['href']}[2] => Github Profile link, string
    # doc.css(".profile-quote").text => Returns profile quote, string
    # doc.css(".description-holder p").text => Returns profile bio, string

    # People who have blogs: Yoshi Tamaoki, Seth Goldberg, Morgan VanYperen, Scotty Runyan, Mitul Mistry, Danny Dawson, Joe Burgess

    #binding.pry

    profile_hash
  end

end

Scraper.scrape_profile_page("http://165.227.31.208:60779/fixtures/student-site/students/joe-burgess.html")
