require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    indices = Nokogiri::HTML(open(index_url))
    #return array of hashes
    students = []
    indices.css("div.student-card").each do |student|
      students << {:name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attribute("href").value}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    #key/value pairs describe an individual student
    profile = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    social_links = []
    social_links = profile.css("div.social-icon-container").children.css("a").collect {|cssline|
      cssline.attribute("href").value}
    social_links.each do |link|
      if link.include?("twitter.com")
        student_profile[:twitter] = link
      elsif link.include?("linkedin.com")
        student_profile[:linkedin] = link
      elsif link.include?("github.com")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = profile.css("div.profile-quote").text if profile.css("div.profile-quote").text
    student_profile[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if profile.css("div.bio-content.content-holder div.description-holder p").text
    student_profile
  end

end
