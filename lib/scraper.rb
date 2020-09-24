require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
     html = open(index_url)
     index = Nokogiri::HTML(html)
     stud=[]
     index.css(".student-card a").each do |student| 
       student_hash = {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.attribute("href").value}
        stud << student_hash
    end
    stud
  end

  def self.scrape_profile_page(profile_url)
     html = open(profile_url)
     profiles = Nokogiri::HTML(html)
     student_profile = {}
     
       social = profiles.css(".social-icon-container a").map {|anchor_tag| anchor_tag.attribute("href").value}
       student_profile[:profile_quote] = profiles.css(".profile-quote").text
       student_profile[:bio] = profiles.css(".description-holder").first.text.gsub("\n","").strip

     social.each do |link|
      if link.include?("twitter")
          student_profile[:twitter] = link
      elsif link.include?("github")
          student_profile[:github] = link
      elsif link.include?("linkedin")
          student_profile[:linkedin] = link
      else 
          student_profile[:blog] = link
        end
      end
 student_profile
end
end

