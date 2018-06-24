require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    scraped_students = []

    doc.css(".student-card").each do |student|
      scraped_students << {
        :name => student.css(".student-name").text,
        :location => student.css(".student-location").text,
        :profile_url => student.css("a").attr("href").value # "#{student.attr("href")}"
      }
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)

    scraped_student = {}

    doc = Nokogiri::HTML(open(profile_url))

    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css(".bio-content p").text

    doc = doc.css(".social-icon-container a").each do |links|

      link = links["href"]
        if link.include?("twitter")
          scraped_student[:twitter] = link
        elsif link.include?("linkedin")
          scraped_student[:linkedin] = link
        elsif link.include?("github")
          scraped_student[:github] = link
        else
          scraped_student[:blog] = link
        end
      end
    scraped_student
  end
end
