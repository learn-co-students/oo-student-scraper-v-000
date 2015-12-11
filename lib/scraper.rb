require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))

     scraped_students = []

    doc.css(".student-card").each do |student|
      scraped_students << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "http://students.learn.co/#{student.css("a").attribute("href").value}"
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}

    doc.css(".social-icon-container a").each do |link|
      normalized_link = link.attribute("href").text

      scraped_student[:twitter] = normalized_link if normalized_link.include?("twitter")
      scraped_student[:linkedin] = normalized_link if normalized_link.include?("linkedin")
      scraped_student[:github] = normalized_link if normalized_link.include?("github")
      scraped_student[:blog] = normalized_link if link.css("img").attribute("src").text.include?("rss")
    end

    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css("bio-content .description-holder p").text

    scraped_student

  end

end
