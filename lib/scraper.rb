require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open("#{index_url}"))
    doc.css("div.student-card").each do |student|
      students << {
        :name => student.css("a div.card-text-container h4").text, 
        :location => student.css("a div.card-text-container p").text, 
        :profile_url => "http://students.learn.co/" << student.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {
      twitter: "https://twitter.com", 
      linkedin: "https://www.linkedin.com/in/", 
      github: "https://github.com", 
      blog: "", 
      profile_quote: "", 
      bio: ""}
    doc = Nokogiri::HTML(open("#{profile_url}"))
    doc.css("div.social-icon-container a"). each do |social_media|
      if social_media.css("img").attribute("src") == "../assets/img/twitter-icon.png"
        student_profile[:twitter] = social_media.attribute("href").value
      elsif social_media.css("img").attribute("src") == "../assets/img/linkedin-icon.png"
        student_profile[:linkedin] = social_media.attribute("href").value
      elsif social_media.css("img").attribute("src") == "../assets/img/github-icon.png"
        student_profile[:github] = social_media.attribute("href").value
      elsif social_media.css("img").attribute("src") == "../assets/img/rss-icon.png"
        student_profile[:blog] = social_media.attribute("href").value 
      end
    end 
    student_profile[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
    student_profile[:bio] = doc.css("div.details-container div.bio-block div.bio-content div.description-holder p").text
    student_profile
  end

end

