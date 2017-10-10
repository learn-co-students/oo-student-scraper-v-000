require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_list = []
    html = open(index_url)
    doc = Nokogiri::HTML(html) 
    students = doc.css(".student-card")
    students.each_with_index do |student, i| ##iterate over each student
      
      this_student_hash = {
        name: student.css(".card-text-container .student-name").text,
        location: student.css("p").text,
        profile_url: student.css("a")[0]["href"]
      }
      student_list << this_student_hash
    end 
    student_list
  end

  def self.scrape_profile_page(profile_url)
    attributes_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    list = doc.css(".social-icon-container")
    list.css("a")[0]["href"]
    list.css("a").each_with_index do |item, i| #iterate over all 'a' tags
      if item["href"].include?("twitter") #search each string for social names
        attributes_hash[:twitter] = item["href"]
      elsif item["href"].include?("linkedin")
        attributes_hash[:linkedin] = item["href"]
      elsif item["href"].include?("github")
        attributes_hash[:github] = item["href"]
      elsif item["href"]
        attributes_hash[:blog] = item["href"]
      end   
    end
    attributes_hash[:profile_quote] = doc.css(".profile-quote").text #scrape quote
    attributes_hash[:bio] = doc.css(".description-holder p").text #scrape bio
    attributes_hash
  end

end

