require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student_info|
      students << {
        :name => student_info.css("h4.student-name").text,
        :location => student_info.css("p.student-location").text,
        :profile_url => student_info.css("a").attribute("href").value
      }
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    profile = doc.css("div.social-icon-container").value
      if profile.include?("twitter")
        student[:twitter] = profile.css("a")[0].attribute("href").value
      elsif profile.include?("linkedin")
        student[:linkedin] = social_link.css("a")[1].attribute("href").value
      elsif profile.include?("github")
        student[:github] = social_link.css("a")[2].attribute("href").value
      elsif profile.include?("blog")
        student[:blog] = social_link.css("a")[3].attribute("href").value
      end
    binding.pry
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
    student
  end

end
