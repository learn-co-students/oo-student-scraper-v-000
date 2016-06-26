require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    doc.css(".student-card").collect do |student|
      students = {
        name: student.css(".student-name").text,
        location: student.css(".student-location").text,
        profile_url: "http://127.0.0.1:4000/" << student.css("a").attribute("href").value
      }
    end
  end # => end method

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    doc.css(".social-icon-container a").each do |student|

      if student.attr("href").include?("twitter")
        scraped_student[:twitter] = student.attr("href")

      elsif student.attr("href").include?("linkedin")
        scraped_student[:linkedin] = student.attr("href")

      elsif student.attr("href").include?("github")
        scraped_student[:github] = student.attr("href")

      elsif student.attr("href")
        scraped_student[:blog] = student.attr("href")

      end 
      scraped_student[:profile_quote] = doc.css(".profile-quote").text
      scraped_student[:bio] = doc.css(".description-holder p").text
     
    end
    scraped_student

  end # => end method

end # => end class
