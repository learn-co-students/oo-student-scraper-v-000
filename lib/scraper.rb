require 'open-uri'
require 'pry'

class Scraper
  BASE_PATH = "./fixtures/student-site/"

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    students = []
    student_cards = doc.css("div.student-card")
    student_cards.each do |student|
      students << {name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: BASE_PATH  + student.css("a").attr("href").text}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    #:twitter, :linkedin, :github = nil
    profile_page_hash = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_vitals=doc.css(".social-icon-container a")
    
    student_vitals.each do |a|
      social_link = a.attr("href")
      if social_link.include?("twitter")
        profile_page_hash[:twitter] = social_link
      elsif social_link.include?("linkedin")
        profile_page_hash[:linkedin] = social_link
      elsif social_link.include?("github")
        profile_page_hash[:github] = social_link
      else
        profile_page_hash[:blog] = social_link
      end
    end
    profile_page_hash[:profile_quote] = doc.css(".vitals-text-container .profile-quote").text
    profile_page_hash[:bio] = doc.css(".details-container .description-holder p").text

    profile_page_hash
  end

end
