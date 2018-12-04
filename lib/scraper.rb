require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = Array.new
    student_data = doc.css("div.roster-cards-container .student-card a")
    student_data.each do |card|
   		student_name = card.css("div:nth-child(2)").css(".student-name").first.text
   		location = card.css("div:nth-child(2)").css(".student-location").first.text
   		profile_url  = card.attribute("href").value
   		student_hash ={:name => student_name, :location => location, :profile_url => profile_url}
   		students << student_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profiles = Hash.new
    student_bio = doc.css(".details-container")
    student_bio.each do |biography|
      bio = biography.css(".description-holder p").text
      profiles[:bio] = bio
    end
    student_profile = doc.css(".vitals-text-container")
    student_profile.each do |profile|
      profile_quote = profile.css(".profile-quote").text
      profiles[:profile_quote] = profile_quote
    end 
    student_urls = doc.css(".social-icon-container a")
    student_urls.each do |url|
      link = url.attributes["href"].value
      if link =~ /twitter/
        profiles[:twitter] = link
      elsif 
        link =~ /linkedin/
          profiles[:linkedin] = link
      elsif 
        link =~ /github/ 
          profiles[:github] = link
      else 
        link =~ !(/twitter/ || /linkedin/ || /github/)
        profiles[:blog] = link
      end 
    end
    profiles
  end
end