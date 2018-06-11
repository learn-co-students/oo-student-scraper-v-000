require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_index = []
    doc.css(".student-card").each do |student|
      student_index << {
      name: student.css(".student-name").text,
      location: student.css(".student-location").text,
      profile_url: student.css("a").attribute("href").value,
    }
    end
    student_index
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    # social links: doc.css(".social-icon-container a").attribute("href").value
    # profile quote: doc.css(".profile-quote").text
    # bio: doc.css(".description-holder p").text
    profile_hash = {}
    social = []
    profile_hash[:profile_quote] = doc.css(".profile-quote").text
    profile_hash[:bio] = doc.css(".description-holder p").text
    doc.css(".social-icon-container a").each do |link|
      social << link.attribute("href").value
    end
    social.each do |link|
      if link.include?("twitter")
        profile_hash[:twitter] = link
      elsif link.include?("github")
        profile_hash[:github] = link
      elsif link.include?("linkedin")
        profile_hash[:linkedin] = link
      else
        profile_hash[:blog] = link
      end
    end
    profile_hash
  end
end
