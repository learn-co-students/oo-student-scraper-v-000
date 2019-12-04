require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
      
    #the page itself = doc = Nokogiri::HTML(open(index_url))
    #the collection of students = doc.css(".student-card")
    #you must assign the project element to a working variable, in this case "student" using student =_
    #the name of an individual student = student.css("h4.student-name").text
    #the location of an individual student = student.css("p.student-location").text
    #the profile_url of an individual student = student.css("a").attribute("href").value
    
    #to return an array of hashes each hash representing an individual student
    students = []
    
    doc.css(".student-card").each do |student|
      student_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << student_hash
    end

    #return the students array of hashes
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    #social_icons = doc.css(".social-icon-container a")
    #social_icon_img_ref = social_icon.css("img").attribute("src").value
    #social_icon_link = social_icon.attribute("href").value

    #profile_quote = doc.css(".profile-quote").text.delete("\"")
    #bio = doc.css(".description-holder p").text

    #:profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
    #:bio=> "I'm a school"

    info = {}

    doc.css(".social-icon-container a").each do |social_icon|
      if social_icon.css("img").attribute("src").value.include?("twitter")
        info[:twitter] = social_icon.attribute("href").value
      end
      if social_icon.css("img").attribute("src").value.include?("linkedin")
        info[:linkedin] = social_icon.attribute("href").value
      end
      if social_icon.css("img").attribute("src").value.include?("github")
        info[:github] = social_icon.attribute("href").value
      end
      if social_icon.css("img").attribute("src").value.include?("rss")
        info[:blog] = social_icon.attribute("href").value
      end
    end
  
    info[:profile_quote] = doc.css(".profile-quote").text
    info[:bio] = doc.css(".description-holder p").text
    
    info
  end
  
end



