require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  attr_accessor :twitter_link
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_name = student.css("h4.student-name").text
        student_location = student.css("p.student-location").text
        student_profile_link = student.attribute("href").value
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students

  end


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    quote = profile_page.css(".profile-quote").text
    bio_para = profile_page.css(".details-container p").text
    student_data = []
    profile_page.css(".social-icon-container a").each do |icon|
      if icon.css(".social-icon").attribute("src").value == "../assets/img/twitter-icon.png"
        twitter_link = icon.attribute("href").value
        
      elsif icon.css(".social-icon").attribute("src").value == "../assets/img/linkedin-icon.png"
        linkedin_link = icon.attribute("href").value
      elsif icon.css(".social-icon").attribute("src").value == "../assets/img/github-icon.png"
        github_link = icon.attribute("href").value
      elsif icon.css(".social-icon").attribute("src").value == "../assets/img/rss-icon.png"
        blog_link = icon.attribute("href").value
      end

      student_data << {twitter: twitter_link, linkedin: linkedin_link, github: github_link, blog: blog_link, profile_quote: quote, bio: bio_para}
    end


    student_data

    end
end
