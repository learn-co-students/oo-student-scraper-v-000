require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_index = Nokogiri::HTML(open(index_url))
    student_index_array = []
    student_hash = {}
    student_index.css("div.student-card").each do |student|
      student_hash = { 
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => index_url.gsub("fixtures/student-site/index.html","") + student.css("a").attribute("href").value 
      }
      student_index_array << student_hash
    end
    student_index_array
  end

  def self.scrape_profile_page(profile_url)
    student_profile = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    student_profile.css("div.social-icon-container a").each do |profile|
      profile_attribute = profile.attribute("href").value
      case
      when profile_attribute.include?("twitter")
        profile_hash[:twitter] = profile_attribute
      when profile_attribute.include?("linkedin")
        profile_hash[:linkedin] = profile_attribute
      when profile_attribute.include?("github")
        profile_hash[:github] = profile_attribute
      when profile.css("img.social-icon").attribute("src").value.include?("rss-icon")
        profile_hash[:blog] = profile_attribute
      end
    end
    profile_hash[:profile_quote] = student_profile.css("div.profile-quote").text
    profile_hash[:bio] = student_profile.css("div.description-holder p").text
    profile_hash
  end

end