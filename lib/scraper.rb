require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.student-card").each do |student|
      students << {
      name: student.css("div.card-text-container h4.student-name").text.split(",")[0],
      location: student.css("div.card-text-container p.student-location").text,
      profile_url: ("./fixtures/student-site/") + student.css("a").attr('href').text}
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    students_info = {}
    students_info[:profile_quote] = doc.css(".profile-quote").text
    students_info[:bio] = doc.css(".description-holder p").text

    doc.css(".social-icon-container a").each do |social|
      social_link = social.attr("href")
      if social_link.include?("twitter")
        students_info[:twitter] = social_link
      elsif social_link.include?("linkedin")
        students_info[:linkedin] = social_link
      elsif social_link.include?("github")
        students_info[:github] = social_link
      else
        students_info[:blog] = social_link
      end
    end
    students_info
  end

end
