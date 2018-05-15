require 'open-uri'
require 'pry'
require 'nokogiri'

require_relative './student.rb'

class Scraper

  def self.scrape_index_page(index_url)

    doc = Nokogiri::HTML(open(index_url))

    # student = doc.css(".student-card a")
    # name = student.first.css("h4").text
    # location = student.first.css("p").text
    # profile_url = student.attribute("href").text

    student_hash = Hash.new
    student_array = Array.new

    doc.css(".student-card a").each do |students|

      student_array << {
      :name => students.css("h4").text,
      :location => students.css("p").text,
      :profile_url => students.attribute("href").text
      }
      #new_student = Student.new(student_hash)
    end
    student_array

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    # doc = div.social-icon-container a
    scraped_student = {}
    #binding.pry

    doc.css("div.social-icon-container a").each do |links|
      link = links.attribute("href").text

      scraped_student[:twitter] = link if link.include?("twitter")
      scraped_student[:linkedin] = link if link.include?("linkedin")
      scraped_student[:github] = link if link.include?("github")
      scraped_student[:blog] = link if links.css("img").attribute("src").text.include?("rss")

    end

    scraped_student[:profile_quote] = doc.css(".profile-quote").text
    scraped_student[:bio] = doc.css("div.bio-content .description-holder p").text

    scraped_student
  end

end
