require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #The return value of this method should be an array of hashes in which each hash represents a single student
    doc = Nokogiri::HTML(open(index_url))

    #name = doc.css(".student-card").first.css(".card-text-container").first.css("h4").text
    #location = doc.css(".student-card").first.css(".card-text-container").first.css("p").text
    #profile_url = doc.css(".student-card").first.css("a").attribute("href").value
    array_of_student_hashes = []
    doc.css(".student-card").each do |card|
      student_hash = Hash.new
      student_hash[:name] = card.css(".card-text-container").first.css("h4").text
      student_hash[:location] = card.css(".card-text-container").first.css("p").text
      student_hash[:profile_url] = card.css("a").attribute("href").value
      array_of_student_hashes << student_hash
    end
    array_of_student_hashes
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_hash = Hash.new
    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".description-holder").first.css("p").text
    social_links = []
    social_info = doc.css(".social-icon-container").css("a")
    social_info.each do |info|
      social_links << info.attribute("href").value
    end
    social_links.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      else #blog
        student_hash[:blog] = link
      end
    end
    student_hash
  end

end
