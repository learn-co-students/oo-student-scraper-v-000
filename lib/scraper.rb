require 'open-uri'
require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    # binding.pry
    scrape = Nokogiri::HTML(open(index_url))
    scraped_students = []
    # binding.pry
    scrape.css("div.student-card").each do |student|
      student = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      scraped_students << student
    end
    scraped_students
  end

  def self.scrape_profile_page(profile_url)
    studentinfo = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    # binding.pry
    studentinfo.css("div.social-icon-container a").each do |links|
      if links.attribute("href").value.include?("twitter")
        scraped_student[:twitter] = links.attribute("href").value
      elsif links.attribute("href").value.include?("git")
        scraped_student[:github] = links.attribute("href").value
      elsif links.attribute("href").value.include?("linkedin")
        scraped_student[:linkedin] = links.attribute("href").value
      else
        scraped_student[:blog] = links.attribute("href").value
      end
    end
    scraped_student[:profile_quote] = studentinfo.css("div.profile-quote").text
    scraped_student[:bio] = studentinfo.css("div.description-holder p").text
    scraped_student
  end

end
