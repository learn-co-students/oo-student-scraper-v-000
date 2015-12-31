require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

    doc.css("div.student-card").each do |student|
      students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "http://students.learn.co/" + student.css("a").attribute("href").text
        }
    end  
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile = {}

    doc.css(".social-icon-container a").each do |link|
      profile[:linkedin] = link.attribute("href").text if link.attribute("href").text.include?("linkedin")
      profile[:twitter] = link.attribute("href").text if link.attribute("href").text.include?("twitter")
      profile[:github] = link.attribute("href").text if link.attribute("href").text.include?("github")
      profile[:blog] = link.attribute("href").text if link.css("img").attribute("src").text.include?("rss")
    end
    profile[:profile_quote] = doc.css("div.profile-quote").text
    profile[:bio] = doc.css("div.description-holder p").text
    profile  
  end

end

