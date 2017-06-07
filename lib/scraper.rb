require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
     doc = Nokogiri::HTML(open(index_url))
     scraped_students = []
     doc.css(".student-card").each do |student|
       scraped_students << {
         name: student.css("h4.student-name").text,
         location: student.css("p.student-location").text,
         profile_url: './fixtures/student-site/' + student.css("a").attr('href').value #{student.attr('href')
        }
      end
      scraped_students
    end

  def self.scrape_profile_page(profile_slug)
    doc = Nokogiri::HTML(open(profile_slug))
    scraped_student = {}
    doc.css(".social-icon-container a").each do |link|
      normalized_link = link.attribute("href").text
      scraped_student[:twitter] = normalized_link if normalized_link.include?("twitter")
      scraped_student[:linkedin] = normalized_link if normalized_link.include?("linkedin")
      scraped_student[:github] = normalized_link if normalized_link.include?("github")
      scraped_student[:blog] = normalized_link if link.css("img").attribute("src").text.include?("rss")
    end
    scraped_student[:bio] = doc.css(".description-holder p").text
    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student
   end
 end
