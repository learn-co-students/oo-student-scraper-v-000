require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card")

    scraped_students = []
    students.each do |instance|
      student_info = {}
      student_info[:profile_url] = instance.css("a").attribute("href").value
      student_info[:name] = instance.css("div.card-text-container h4").text
      student_info[:location] = instance.css("div.card-text-container p").text
      scraped_students << student_info
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    social = doc.css("div.social-icon-container a")
    links = []
    social.each do |link|
      links << link.attribute("href").value #Gets all social media links in an array
    end
    twitter = nil # links.find {|link| link.include?("twitter")}
    linkedin = nil # links.find {|link| link.include?("linkedin")}
    github = nil # links.find {|link| link.include?("github")}
    blog = nil

    links.each do |link|
      if link.include?("twitter")
        twitter = link
      elsif link.include?("linkedin")
        linkedin = link
      elsif link.include?("github")
        github = link
      else
        blog = link
      end
    end

    quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text

    student_info = {}
    student_info[:twitter] = twitter if twitter
    student_info[:linkedin] = linkedin if linkedin
    student_info[:github] = github if github
    student_info[:blog] = blog if blog
    student_info[:profile_quote] = quote if quote
    student_info[:bio] = bio if bio
    student_info
  end

end
