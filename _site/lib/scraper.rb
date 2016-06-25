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
      url = profile.attribute("href").value
      case
      when url.include?("twitter")
        profile_hash[:twitter] = url
      when url.include?("linkedin")
        profile_hash[:linkedin] = url
      when url.include?("github")
        profile_hash[:github] = url
      when profile.css("img.social-icon").attribute("src").value.include?("rss-icon")
        profile_hash[:blog] = url
      end
    end
    profile_hash[:profile_quote] = student_profile.css("div.profile-quote").text
    profile_hash[:bio] = student_profile.css("div.description-holder p").text
    profile_hash
  end

end