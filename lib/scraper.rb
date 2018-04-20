require  'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student = []
    doc = Nokogiri::HTML(open(index_url))
    scraper_doc   = doc.css(".student-card a")
    scraper_doc.each do |student_row|
      student <<
        {
          :name =>  student_row.css(".student-name").text,
          :location =>  student_row.css(".student-location").text,
          :profile_url =>  student_row.attr("href")
        }
    end
      student
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    doc = Nokogiri::HTML(open(profile_url))
    student[:bio]   =   doc.css("div.bio-content.content-holder div.description-holder p").text
    student[:profile_quote] = doc.css(".profile-quote").text

    social_link = doc.css(".social-icon-container a")

    # Extract all URL of all social links
    social_link_array = []
    social_link.each do |social|
      social_link_array << social.attr("href")
    end

    social_link_array.each do |linkurl|
    if linkurl.include?("linkedin")
      student[:linkedin] = linkurl
    elsif linkurl.include?("github")
      student[:github] = linkurl
    elsif linkurl.include?("twitter")
      student[:twitter] = linkurl
    else
      student[:blog] = linkurl
    end
  end
  student
end
end
#Scraper.scrape_index_page("fixtures/student-site/index.html")
Scraper.scrape_profile_page("fixtures/student-site/students/ryan-johnson.html")
