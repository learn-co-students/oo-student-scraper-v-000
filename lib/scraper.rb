  
require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_url = open("./fixtures/student-site/index.html")
    doc = Nokogiri::HTML(index_url)
    students = doc.css(".student-card")
    scraped_students = []
    students.map do |student|
      student_hash = {name: student.css(".student-name").text, location: student.css(".student-location").text, profile_url: student.css("a")[0]["href"]}
       scraped_students << student_hash
     end
    scraped_students
    end

  def self.scrape_profile_page(profile_url)
    profile = open(profile_url)
    doc = Nokogiri::HTML(profile)
    social_icons = doc.css(".social-icon-container a img")
    icon_link = []
    link = []
    social_icons.map do |links|
      icon_link << links["src"]
    end
    social_links = doc.css(".social-icon-container a")
    social_links.map do |links|
      link << links["href"]
    end
    
    twitter_icon = ""
    linkedin_icon = ""
    github_icon = ""
    blog_icon = ""
    icon_link.map do |each_icon|
      if each_icon.include?("twitter")
        twitter_icon = each_icon
      else 
        twitter_icon = nil 
      end
      if each_icon.include?("linkedin")
        linkedin_icon = each_icon
      else 
        linkedin_icon = nil
      end
      if each_icon.include?("github")
        github_icon = each_icon
      else 
        github_icon = nil
      end
      if each_icon.include?("rss")
        blog_icon = each_icon
      else 
        blog_icon = nil
      end
    end

  if twitter_icon != nil 
    twitter_link = link[icon_link.index(twitter_icon)]
  else 
    twitter_link = nil
  end
  if linkedin_icon != nil
    linkedin_link = link[icon_link.index(linkedin_icon)]
  else 
    linkedin_link = nil
  end 
  if github_icon != nil
    github_link = link[icon_link.index(github_icon)]
  else 
    github_link = nil
  end
  if blog_icon != nil
    blog_link = link[icon_link.index(blog_icon)]
  else 
    blog_link = nil
  end
  
 
  profile_hash = {twitter: twitter_link, linkedin: linkedin_link, github: github_link, blog: blog_link, profile_quote: doc.css(".profile-quote").text, bio: doc.css(".bio-content p").text}
      
    new_hash = profile_hash.delete_if{|key, value| value == nil}
    
    new_hash
    
   end
    


end

