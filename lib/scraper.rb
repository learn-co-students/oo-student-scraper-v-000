require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = open(index_url)
    doc = Nokogiri::HTML(index_page)
    students = []
    doc.css(".roster-cards-container").each do |student|
      student.css(".student-card").each do |profile|
        name = profile.css(".student-name").text
        location = profile.css(".student-location").text
        profile_url = profile.css("a").attribute("href").value
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = open(profile_url)
    doc = Nokogiri::HTML(profile_page)
    student_profile = {}
    links = doc.css(".social-icon-container").css("a").collect { |info| info.attribute("href").value }
    links.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link
      elsif link.include?("github")
        student_profile[:github] = link
      else
        student_profile[:blog] = link
      end
    end
    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".details-container").css("p").text
    student_profile
  end
end
