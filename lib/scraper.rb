require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []
    doc.css(".student-card").each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").attribute("href").value
      scraped_students << student_hash
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
      doc = Nokogiri::HTML(open(profile_url))
      student_hash = {}
      links = doc.css(".social-icon-container").children.css("a")
      links.each do |link|
      link = link.attribute("href").value
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("github")
            student_hash[:github] = link
      elsif link.include?("linkedin")
            student_hash[:linkedin] = link
          else
            student_hash[:blog] = link
          end
      end

      student_hash[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
      student_hash[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
      student_hash
    end


end
