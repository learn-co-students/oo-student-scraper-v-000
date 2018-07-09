require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    array = []

    doc.css(".student-card").each do |student|
       array << {name: student.css(".student-name").text,
       location: student.css(".student-location").text,
       profile_url: student.css("a").attribute("href").value}
     end
    array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}

    doc.css(".social-icon-container").children.css("a").each do |link|
    
      if link.attribute("href").value.include?("twitter")
        student_hash[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        student_hash[:github] = link.attribute("href").value
      else link.attribute("href").value.include?("blog")
        student_hash[:blog] = link.attribute("href").value
      end
    end
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder p").text
    # binding.pry
    student_hash
  end
    
    
end

