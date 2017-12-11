require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css(".roster-cards-container").each do |student|
      student.css(".student-card").each do |student_info|
        name = student_info.css("h4.student-name").text
        location = student_info.css("p.student-location").text
        url = student_info.css("a").first.attributes["href"].value
        students << {name: name, location: location, profile_url: url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    social_media = doc.css("div.social-icon-container a")
    sites = social_media.collect  {|item| item.attributes["href"].value}
      sites.each do |site|
        if site.include?("twitter")
          student[:twitter] = site
        elsif site.include?("linkedin")
          student[:linkedin] = site
        elsif site.include?("github")
          student[:github] = site
        else
          student[:blog] = site
        end
      end
    student[:profile_quote] = doc.css("div.profile-quote").text
    student[:bio] = doc.css("div.bio-content").css("div.description-holder p").text
    student
  end

end
