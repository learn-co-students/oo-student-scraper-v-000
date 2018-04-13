  
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
        social_icons = doc.css(".social-icon-container a")
         link = []
        links = social_icons.map do |links|
          link << links["href"]
        end
        twitter_a = ""
        linked_in = ""
        git_hub = ""
        blog_a = ""
       link.map do |each_link|
        if each_link.include?("twitter")
          twitter_a = each_link
        elsif each_link.include?("linkedin")
          linked_in = each_link 
        elsif each_link.include?("github")
          git_hub = each_link
        elsif each_link.include?("github")
        end
        binding.pry
        doc.map do |profiles|
        profile_hash = {twitter: social, linkedin: social, github: social, blog: social, profile_quote: profile.css(".profile-quote").text, bio: profile.css(".bio-content p").text}
      end
      
    end


end

