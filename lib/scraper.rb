require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".student-card").collect do |student|
      student_hash = {}
      student_hash[:name] = student.css("h4").text
      student_hash[:location] = student.css("p").text
      student_hash[:profile_url] = student.css("a").attr("href").value
      students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_hash = {}
    student_hash[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    doc.css(".social-icon-container a").each do |type|
      link = type.attr("href")
      if link.include? "twitter"
        student_hash[:twitter] = link
      elsif link.include? "linkedin"
        student_hash[:linkedin] = link
      elsif link.include? "github"
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    student_hash
  end
end
