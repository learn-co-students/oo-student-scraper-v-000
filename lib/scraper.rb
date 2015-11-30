require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  # #scrape_index_page is a class method that scrapes the student index page and 
  # returns an array of hashes in which each hash represents one student
  
  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    scraped_students = []
    students = doc.css(".student-card")
    
    students.each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "http://students.learn.co/#{student.css("a").attribute("href").value}"
        scraped_students << {:name => name, :location => location, :profile_url => profile_url}
    end
    scraped_students
  end

  # scrape_profile_page is a class method that scrapes a student's profile page and returns a 
  # hash of attributes describing an individual student

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
  

    student_info = {}
     
    doc.css(".social-icon-container").each do |social_icon|

      if social_icon.include?("twitter")
        twitter = doc.css(".social-icon-container a")[0].attribute("href").value
      else
        ""
      end

      if social_icon.include?("linkedin")
        linkedin = doc.css(".social-icon-container a")[1].attribute("href").value
      else
        ""
      end

      if social_icon.include?("github")
        github = doc.css(".social-icon-container a")[2].attribute("href").value
      else
        ""
      end

      if social_icon.include?("rss")
        blog = doc.css(".social-icon-container a")[3].attribute("href").value
      else
        ""
      end

      profile_quote = doc.css(".profile-quote").text
      bio = doc.css(".description-holder p").text
      student_info = {:twitter => twitter, :linkedin => linkedin, :github => github, :blog => blog, 
        :profile_quote => profile_quote, :bio => bio}
   end
    student_info
  end

end
