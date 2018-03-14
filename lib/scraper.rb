require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)

    scraped_students = []

    html = open("fixtures/student-site/index.html")
      doc = Nokogiri::HTML(html)
      doc.css(".roster-cards-container").each do |card|
        doc.css(".student-card a").each do |student|
          name = student.css(".student-name").text
          location = student.css(".student-location").text
          profile_url = "./fixtures/student-site/#{student.attr('href')}"
          scraped_students << {name: name, location: location, profile_url: profile_url}
        end
      end
      scraped_students
  end

  def self.scrape_profile_page(profile_url)

    profile_url = Nokogiri::HTML(open(profile_url))

    scraped_student = {}

    links = profile_url.css(".social-icon-container").children.css("a").map do |a|
      a.attribute("href").value
      end
      
    links.each do |url|
      if url.include?("linkedin")
        scraped_student[:linkedin] = url
      elsif url.include?("github")
        scraped_student[:github] = url
      elsif url.include?("twitter")
        scraped_student[:twitter] = url
      else
        scraped_student[:blog] = url
      end
        scraped_student[:bio] = profile_url.css("div.bio-content.content-holder div.description-holder p").text if profile_url.css("div.bio-content.content-holder div.description-holder p")
        scraped_student[:profile_quote] = profile_url.css(".profile-quote").text if profile_url.css(".profile-quote")
      end
    scraped_student
  end

end
