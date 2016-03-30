require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_info = index_page.css("div.student-card")
    students = []
    student_info.each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = index_url + student.css("a").first["href"]
      student_hash = {name: name, location: location, profile_url: profile_url}
      students << student_hash
    end
    return students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    social = profile_page.css("div.social-icon-container a")
    social.each do |link|
      if link["href"].include? "twitter"
        profile_hash[:twitter] = link["href"]
      elsif link["href"].include? "linkedin"
        profile_hash[:linkedin] = link["href"]
      elsif link["href"].include? "github"
        profile_hash[:github] = link["href"]
      else
        profile_hash[:blog] = link["href"]
      end
    end

    profile_hash[:profile_quote] = profile_page.css("div.profile-quote").text
    profile_hash[:bio] = profile_page.css("div.description-holder p").text
    
    return profile_hash
  end

end

